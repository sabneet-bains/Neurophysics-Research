#!/usr/bin/env python

import os
from explore import parse, main
from explore.utils.internal import query_yes_no
from explore.utils import calc
from explore.modes.place import PlaceMode, PlaceModeRandom, PlaceModeCrystal
from explore.modes.connect import ConnModeBlockRandom, ConnModeBlockRandomGrid
from explore.modes.connect.core import macrocolumn
from explore.modes.sim import SimModeBinaryRandom
from explore.modes.spike import SpikeModeA11
from explore.modes.mode import Mode

#### PLACE MODES ####
top_dir = 'block_inhib_test_0.95'
L = 256.
num_place = 10
num_block_list = [2]

#### CONNECTION MODES ####
xs, ys = (25, 28, 30, 33, 35, 38, 40), (0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9)
x_in = 10

#### SIMULATION MODES ####
T = [20]
sim_mode_paperl = SimModeBinaryRandom( 'sim' , time = (10000,), stim = 35, EE = 0.45)
SMODE_delay = [SimModeBinaryRandom( 'delay_%g' %t, time = (10000,), stim = 35, EE = 0.95,
               vlong = 300./t, vhsort = 150./t, vcutoff = 300.) for t in T]

# ALL modes together
place_kwargs = {
    'SLICEGEN_INTERST_NEURON_FRAC':0.2,
    'SLICEGEN_INTER_NEURON_DELTA':25.6,
    'SLICEGEN_XY_NEURON_DELTA':25.6,
    'SLICEGEN_PUT_NICE_Z':False,
    'SLICEGEN_SKIP_NEURON_FRAC':0.4,
}

MODES = []
# Place modes
for i in range(len(SMODE_delay)):

    MODES += [Mode(
    PlaceModeRandom(os.path.join(top_dir, 'N%g' %NB), num_place, L, **place_kwargs),
    ConnModeBlockRandomGrid('block', x = xs, y = ys, block_len = NB,
    inhib_mode = macrocolumn.inhib_iso_exp_dist, in_cpn = x_in),
    SMODE_delay[i], SpikeModeA11('', tstart = 500, block_len = (NB,))) for NB in num_block_list]

if __name__ == '__main__':
    args = parse()
    if args.overwrite:
        query_yes_no("WARNING! You have selected to overwrite current modes! Is this what you intended?")
    
    main(args.stages, MODES, overwrite = args.overwrite, verbose = args.verbose, dry = args.dry_run)
