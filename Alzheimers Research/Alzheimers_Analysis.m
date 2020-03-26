%--------------
clear all     %| Memory cleaning block
clear classes %| flushes out everything
clear clc     %| including java, classes
clear java    %| and command window...
%--------------

%[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[---------------------DEBUGGER------------------------]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

debugger = questdlg('Would you like to run in debug mode?','Debugger','Yes','No','No');
switch debugger % For now this only skips the GUI but more functionality can be added in the future...
    case 'Yes'
        if ~exist('/rair-pipeline/DATA/sabneet/variables.mat','file')
            gui = 1; % Intializing and aborting mechanism
            fprintf('\n\t\t\tThe [\b"variables.mat"]\b workspace matrix does not exist in [\b"/rair-pipeline/DATA/sabneet/"]\b')
            fprintf('\n\n\t\t\t         Please consider correcting this in order to use the debugger!')
            fprintf('\n\n\t\t\t            Until then the program can simply run in [\bNormal Mode...]\b')
            pause(8);
            fprintf(repmat(sprintf('\b'), 1, 250));
            fprintf('[\bRunning in Normal Mode: ]\b');
            fprintf(2,'(Debugger Failed)\t');
            pause(1);
        else
            load('/rair-pipeline/DATA/sabneet/variables.mat')
            gui = 0; % Does not allow the GUI to initiate based on the above user response
            main = 1; % Initiates the MAIN PROGRAM variable as a true boolean
        end
    case 'No'
        gui = 1; % Allows the GUI to initiate based on the above user response 
        main = 0; % Initiates the MAIN PROGRAM variable as a fasle boolean
    case ''
        gui = 0; % Does not allow the GUI to initiate based on the above user response
        main = 0; % Initiates the MAIN PROGRAM variable as a fasle boolean
end

%[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[---------------GRAPHICAL USER INTERFACE--------------]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

while gui ~= 0 % GUI Loop that runs as long the gui variable is not zero
    main = 1; % MAIN PROGRAM initializer
    
                         %___________________________HYBRID JAVA BASED GUI_______________________________%
                            
    frame1 = javax.swing.JFrame; % Creates the first java swing JFrame object
    frame2 = javax.swing.JFrame; % Creates the second java swing JFrame object
    frame1.setUndecorated(true); % Removes the window decorations inlcuding title bar and whole window chrome from the first JFrame
    frame2.setUndecorated(true); % Removes the window decorations inlcuding title bar and whole window chrome from the second JFrame
    frame1.getContentPane.setOpaque(false); % Sets the first JFrame's JPanel to transparent
    frame2.getContentPane.setOpaque(false); % Sets the second JFrame's JPanel to transparent
    frame1.getContentPane.setDoubleBuffered(true); % Manually forces double buffering on first JFrame's JPanel
    frame2.getContentPane.setDoubleBuffered(true); % Manually forces double buffering on second JFrame's JPanel
   
    label1 = javax.swing.JLabel('<html><img src = "http://i.imgur.com/8YsAmq3.gif" /></html>'); % Uses HTML to read in an online .gif image as the JLabel for first JFrame
    img2 = imread('/rair-pipeline/DATA/sabneet/brain_scaled.png'); % Reads in the local brain_scaled image for the second JFrame
    jimg2 = im2java(img2); % Converts the local brain_scaled image into a java image
    icon2 = javax.swing.ImageIcon(jimg2); % Creates an image icon from the recently created java image
    label2 = javax.swing.JLabel(icon2); % Creates a JLabel using the image icon for second JFrame
    
    frame1.getContentPane.add(label1); % Adds the first JLabel to the first JFrame
    frame2.getContentPane.add(label2); % Adds the second JLabel to the second JFrame
    frame1.pack; % Packs the first JFrame into a single object
    frame2.pack; % Packs the second JFrame into a single object

    frame1.setSize(390,300); % Sets the size of the first JFrame
    frame2.setSize(700,400); % Sets the size of the scond JFrame
    screenSize = get(0,'ScreenSize');  % Gets the screen size from the root object
    frame1.setLocation((screenSize(3)-1800)/2,(screenSize(4)-300)/2); % Sets the desired screen location for the first JFrame
    frame2.setLocation((screenSize(3)-2100)/2,(screenSize(4)-360)/2); % Sets the desired screen location for the second JFrame

    frame1.show; drawnow; pause(1.8); % 1). The first JFrame becomes visible 2). It is drawn immediately 3). Then there is a pause of 1.8 seconds just to enjoy the animation!
    frame2.show; drawnow; frame1.hide; pause(5); frame2.hide; % 1). The second JFrame becomes visible 2). It is drawn immediately 3). The first JFrame is hidden 4). A pause for 5 seocnds 5). Finally, the second JFrame gets hidden as well.
    clear java; % Clears the Java objects to free up memory and insure a smooth transition

                       %___________________________MATLAB'S JAVA BASED GUI_______________________________%
                        
    prompt = {'DEFAULT INPUT PATH:','FIRST PATH IDENTIFIER:','SECOND PATH IDENTIFIER:',...
        'DIRECTORY FOLDER IDENTIFIER:','FILES FOR PARSING:', 'DEFAULT OUTPUT PATH:'}; % Creates a cell containing all these substrings
    dlg_title = 'The Program Defaults'; % Title of the UI dialog window
    default_files = {'original_pet.nii.gz','mc_dynamic_original_pet.nii.gz','original_mri.nii.gz',...
        'MNI152_T1_2mm_brain.nii.gz','mri2atlas.mat',...
        'pet2mri.mat','gm2atlas.nii.gz','wm2atlas.nii.gz'}; % Creates a cell containing the default filenames of the interested files
    defaults = {'/isilon-imaging/DDBS/AV-1451-A09/Analyze/AV1451','isilon-imaging',...
        'AV-1451-A09','-AV1451-BASELINE-ANALYSIS',char(default_files),'/rair-pipeline/DATA/sabneet/'}; % Combines the defaults as one cell containing all the default values
    identifier = inputdlg(prompt,dlg_title,[1 100; 1 100; 1 100; 1 100; 8 100; 1 100],defaults); % Finally, all the prep in previous steps gets populated in a dialog window

    if isempty(identifier) % Checks whether the user canceled the prompt
        gui = 0; % Does not allow the GUI to initiate based on the above user response
        main = 0; % Initiates the MAIN PROGRAM variable as a fasle boolean
        break;
    else
        spaces = cell(1,numel(identifier)); % Pre-allocates a cell that will check for dangling spaces after an incomplete deletion of some defaults field
        for s = 1:numel(identifier)
            spaces{s} = numel(strtrim(char(identifier(s)))); % Checks which, (if any) of the defaults contained leftover spaces
        end
        
        blanks = find(cellfun(@(x)isequal(x,0),spaces)); % Checks for blanks and spaces in the defaults window; x is a dummy variable i.e. part of syntax  
        if ~isempty(blanks)  % If the newly created blanks cell is not empty (meaning it indeed found some blank field(s)) only then this conditional executes
            blank_fields = strcat({'       '},'"',char(prompt(blanks)),'"'); % Formatting for the warning dialog text containg empty/blank field names
            w = warndlg({'The defaults dialog window contained blanks!', 'Mainly the following field(s):','',char(blank_fields),''}); % Warning dialog
            w_button = findobj(w, 'style', 'pushbutton'); % Finds the pushbutton on warning dialog GUI; this is the OK button that we need to change the text of
            set(w_button,'String', ' RESET '); % Changes the default text of warning dialog's OK button to RESET
            drawnow % Immediately draws the GUI
            waitfor(w); % Waits for user interaction with the warning dialog box
            gui = 1; % Allows the GUI to reinitiate
            main = 0; % Sets j = 0 which stops any further initiation of the main program
        else
            choice = questdlg('Would you like to go ahead with the defaults?', ...
            'Time for Action', ...
            'Yes','No, I selected the wrong directory','RESET','RESET'); % Double checking mechanism in case the user hastly pressed okay on the previous prompt
            drawnow; % Immediately draws the GUI
            switch choice
                case 'Yes'
                    path = char(identifier(1)); %-------------------------------------------Default as of 5/19/2016---------------------------------------------------------------------------------   
                    gui = 0; % Smooth sailing gui = 0
                    main = 1; % Initiates the MAIN PROGRAM variable as a true boolean
                case 'No, I selected the wrong directory'
                    path = uigetdir(); % In this case overwrites the path variable as user gets a second chance to provide the correct directory 
                    check = strfind(path,char(identifier(2))); % Checks the user provided path for an instance of like 'AV-1451-A09' or some other identifier
                    double_check = strfind(path,char(identifier(3))); % Extra counter measure to make it uterly sure that indeed the correct path was selected

% NOTE: in order for this to work the user must have provided the correct identifiers to begin with; highly unlikely this will be true

                    if check & double_check >= 1                          
                        gui = 0; % Smooth sailing gui = 0
                        main = 1; % Initiates the MAIN PROGRAM variable as a true boolean
                    else
                        uiwait(warndlg('Try again, wrong directory or identifier(s)!')); % Warning when the wrong directory is selected
                        drawnow; % Immediately draws the GUI
                        gui = 1; % Oh, no got to reinitiate the while loop
                        main = 0; % Initiates the MAIN PROGRAM variable as a false boolean
                    end
                case 'RESET'
                    gui = 1; % Allows the GUI to reinitiate based on the above user response 
                    main = 0; % Initiates the MAIN PROGRAM variable as a false boolean
                case '' % Extra pre-caution in case the users keeps on jumping back and forth on GUI, this essentially prevents a forever loop!
                    gui = 0; % Smooth sailing gui = 0
                    main = 0; % Initiates the MAIN PROGRAM variable as a false boolean
                    break; % Technically, what this does is allow the GUI to close through the close X button if the user choice is X or '' in Matlab speak
            end
        end
    end
end

%[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[-------------------THE MAIN PROGRAM-------------------]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

while main ~= 0 % The main program only initiates if thus far j was not set to zero in the code above ^
    cd(path) % Changes current working directory to the default input path 
    content = dir(strcat('*',char(identifier(4)))); % Since, already cd'ed into path now it is easier to look for the DIRECTORY FOLDER IDENTIFIER:  
    name = {content.name}; % Parse out just the names from the content cell
    name_num = numel(name); % Count the total amount of names
    default_files = cellstr(strtrim(char(identifier(5)))); % Re-writing the original variable "default_files" in much better cell string form
    default_files_num = numel(default_files); % Count the total number of strings in "default_files" , i.e. FILES FOR PARSING:

    c = clock; % Initial allocation of Matlab's in-built clock function
    counter = 0; % Percentage counter to find accurate progress bar values
    empty_string = ''; % Pre-allocation of an empty string for the progress bar
    folders = cell(1,name_num); % Pre-allocation of total folders cell
    subject_id = cell(1,name_num); % Pre-allocation of subject id based identifiers
    
                              %___________________________FILE TRANSFER_______________________________%
    tic % Initiates Matlab's in-built tic function to record the elapsed time
    fprintf('\n\n[[[[[[[[[[[[[[[[[[[[                                                                    ]]]]]]]]]]]]]]]]]]]]\n');
    fprintf('[[[[[[[[[[[[[[[[[[[[------------------------------STEP ONE------------------------------]]]]]]]]]]]]]]]]]]]]\n');
    fprintf('[[[[[[[[[[[[[[[[[[[[                                                                    ]]]]]]]]]]]]]]]]]]]]\n\n\n\n');
    
    for n = 1:name_num %======================================================================-Subjects Loop
        for m = 1:default_files_num %============================================================-Files Loop

            look = ls(fullfile(char(name(n)),'*','*','*',char(default_files(m)))); % Lists a fullfile path with wildcards in the pet folder looking for FILES FOR PARSING:
            counter = counter + 1; % Iterates the progress bar counter

            subject_id{n} = look(1:8); % Parses out the first 8 letters of the filename; COULD BE ERORRENOUS IN CASE FILENAMES THAT DO NOT FOLLOW CONVENTION!!!
            files = strcat(char(identifier(1)),'/',look); % Creates the whole long pathname for each single file
            folders(n) = cellstr(strcat(char(identifier(6)),char(subject_id(n)))); % Creates a cell containg subject id specific folder names

            if ~exist(char(folders(n)),'file') % Checks in the "path" if folders with such filenames actually exist there
                mkdir(char(folders(n))); % If true then Subject ID specific folders are created
% %             else
% %                 j = 0;
% %                 disp(strcat('The ',char(folders(n)),' folder already exists!'))
% %                 break;
            end

            study_number = '-1_'; % Prefixes to distinguish whether it is a baseline study, follow-up 1 or a follow-up 2 study
            if isequal(strfind(look, 'Baseline'),0) % Checks if "look" does not contain a string named 'Baseline'
               study_number = '-2_'; % Assigns the corresponding study number 
               if isequal(strfind(look, 'Follow_up'),0) % Checks if "look" does not contain a string named 'Follow_up'
                   study_number = '-3_'; % Assigns the corresponding study number 
               end
            end

            copied_files = copyfile(files, char(identifier(6))); % Copies the files form input path to the output path
            renamed_files = strcat(char(subject_id(n)),study_number, char(default_files(m))); % Corrects for the naming convention, where we place the subject id as prefix to the newly copied files

            moved_files1 = strcat(char(identifier(6)),char(default_files(m))); % Sets up the non-name changed files, i.e. copied files with the original filenames
            moved_files2 = strcat(char(identifier(6)),renamed_files); % Creates a full path string with the new subject id specific filenames
            movefile(moved_files1, moved_files2); % Renames the originally copied files with the subject specific prefixes
            movefile(moved_files2, strcat(char(folders(n)))) % Finally moves all these files with a certain subject id into its own subject id specific folder
            
            if isequal(counter,1) % Records the clock time on first run, i.e while counter was 1
                is = etime(clock,c); % Finds the difference between first run clock time and intial allocation time
                esttime = is *(default_files_num*name_num*0.424); % Estimates the time it will require to finish the task
            end
            
            if counter < (default_files_num*name_num) % Allows the seconds varaible to be used for both step one and step two
                seconds = abs(esttime-etime(clock,c)); % In step one this provides the remaining seconds till completion
            else
                seconds = 97.5*numel(folders); % In step two this tries its best to fudge an estimated completion time in seconds; here 97.5 is a mere fudge factor determinded after continous testing!
            end
            
            minutes = seconds/60; % Converts seconds into minutes
            min_int = floor(minutes); % Keeps only the integer value of the recently created duration_minutes
            sec_deci = ceil((minutes- min_int)*60); % Converts the remaining decimals into seconds

            percentDone = 100*counter/(default_files_num*name_num); % Calculates the percent done so far based on the counter and total number of files
            toc_seconds = toc; % records the toc based seconds in a variable named toc_seconds
            toc_minutes = toc_seconds/60; % Converst toc_seconds into minutes
            toc_min_int = floor(toc_minutes); % Keeps only the integer value of the recently created duration_minutes
            toc_sec_deci = ceil((toc_minutes - toc_min_int)*60); % Converts the remaining decimals into seconds
            
            if ~isequal(counter,(default_files_num*name_num)) % While counter does not equal total number of files..
                message1 = sprintf('\t\t\t\t\t  Transfering Files: %4.1f', percentDone); % Creates a tabbed Transfering Files with 4-point precision percentage
                message2 = sprintf('\n\n\t\t\t     Estimated Time Remaining: %4.1f', min_int); % Creates tabbed Time Remaining on the next line with 4-point precision minutes
                message3 = sprintf('%5.1f',sec_deci); % Creates on the same line as above but with 5-point precision seconds
                message4 = sprintf('\n\n\t\t\t\tActual Time Elapsed: %4.1f',toc_min_int'); % Creates a tabbed Actual Time Elapsed on the next line with 4-point precision toc minutes
                message5 = sprintf('%5.1f',toc_sec_deci); % Creates on the same line as above with 5-point precision toc seconds
                fprintf([empty_string, message1, ' %%', message2, ' minutes' , message3 , ' seconds', message4, ' minutes', message5, ' seconds']); % Displays all of the above in the command window
                empty_string = repmat(sprintf('\b'), 1, 145); % Erases all the content over and over again to give the allusion of updating percentage and time
            else
                message1 = sprintf('\t\t\t\t\t  Transfering Files: %4.1f', percentDone); % Creates a tabbed Transfering Files with 4-point percision percentage
                message2 = sprintf('\n\n\t\t\t\tActual Time Elapsed: %4.1f',toc_min_int'); % Creates a tabbed Actual Time Elapsed on the next line with 4-point precision toc minutes
                message3 = sprintf('%5.1f',toc_sec_deci); % Creates on the same line as above with 5-point precision toc seconds
                message4 = sprintf('\n\n\t\t\t\t\t      Transfer Finished!'); % Replaces the time remaining with static FINISHED text
                fprintf([empty_string, message1, ' %%', message2, ' minutes', message3, ' seconds', message4 ]); % Displays all of the above in a static manner this time
            end
        end
    end 
                         %___________________________FSL AND SPM TRANSFORMATIONS_______________________________%
    tic % Resets the tic function to record the elapsed time for STEP TWO
    fprintf('\n\n\n\n[[[[[[[[[[[[[[[[[[[[                                                                    ]]]]]]]]]]]]]]]]]]]]\n');
    fprintf('[[[[[[[[[[[[[[[[[[[[------------------------------STEP TWO------------------------------]]]]]]]]]]]]]]]]]]]]\n');
    fprintf('[[[[[[[[[[[[[[[[[[[[                                                                    ]]]]]]]]]]]]]]]]]]]]\n\n\n\n');
    fprintf(char(strcat('\t\t\t You better get some popcorn as this process is really slow!\n     On a good day this should take less than',{' '},num2str(min_int),{' mins and'},{' '},num2str(sec_deci), ' seconds, but fear not young one your future\n      is still bright...\n\n'))); % Changes console line in the anticipation of the second progress bar
    fprintf('\n\n\t\t\t\t\tFSL & SPM Transformations: 0.0 %%'); % Creates a tabbed FSL AND SPM Transformations with 4-point precision percentage
        
    cd(char(identifier(6))); % Changes directory to the DEFAULT OUPUT PATH
    mc_dynamic_original_pet = cell(1,numel(folders)); % Creates an empty cell the size of all the subject specific folders just created in the output path 
    pet2mri_files = cell(1,numel(folders)); % Creates an empty cell the size of all the subject specific folders just created in the output path
    mri2atlas_files = cell(1,numel(folders)); % Creates an empty cell the size of all the subject specific folders just created in the output path

    % pet2pet_files = cell(1,numel(folders)); % Not needed just yet!

    empty_string = ''; % Overwrites and pre-allocates an empty string for the progress bar

    for p = 1:numel(folders) % Runs a for loop from 1 to the number of the subject id specific folders just created in the output path
        mc_dynamic_original_pet{p} = ls(fullfile(char(folders(p)),'*_mc_dynamic_original_pet.nii.gz')); % fills the empty original_pet.nii.gz with all the pathnames for these files under the subject specific folders
        pet2mri_files{p} = ls(fullfile(char(folders(p)),'*pet2mri.mat')); % fills the empty pet2mri_files with all the pathnames for these files under the subject specific folders
        mri2atlas_files{p} = ls(fullfile(char(folders(p)),'*mri2atlas.mat')); % fills the empty mri2atlas_files with all the pathnames for these files under the subject specific folders

        %     pet2pet_files{p} = ls(fullfile(char(folders(p)),'*pet2pet.mat')); % Not there yet
        %     concatenate = strcat('convert_xfm -omat',{' '},subject_id(p),'-petDirect2mri',' -concat', char(pet2mri_files{p}), char(pet2pet_files{p})); % Again not ready yet

        %---Creates a string that calls on the fsl's flirt function with input mc_dynamic_original_pet;
        % then applies applyxfm on it and the pet2mri_files with output being petDirect2mri.mat;
        % alongside trilinear interoplation is run using the MNI152_T1_2mm_brain as the reference

        fsl_flirt4D = strcat('/usr/local/fsl/bin/flirt -in',{' '}, char(mc_dynamic_original_pet{p}), ' -applyxfm -init',{' '}, char(pet2mri_files{p}), ' -out',{' '}, char(fullfile(folders(p), strcat(subject_id(p), '_petDirect2mri.mat'))), ' -interp trilinear -ref /usr/local/fsl/data/standard/MNI152_T1_2mm_brain');
        unix(char(fsl_flirt4D)); % This actually runs the above commands using unix system defined program (in this case it will be the terminal)
        cd(char(folders(p))); % Changes the directory in to the iterated subject specific folder

        %---------------------------------------------------------------------------------------------

        %   unzip = gunzip(strcat(char(subject_id(p)),'_petDirect2mri.mat.nii.gz')); % MATLAB IN-BUILT GUNZIP; WEIRDLY DOES NOT REMOVE THE ORIGNAL AFTER UNZIPPING

        unzip = strcat('gunzip',{' '}, subject_id(p), '_petDirect2mri.mat.nii.gz'); % Unzips the _petDirect2mri.mat.nii.gz files that FSL just created as zips
        unix(char(unzip)); % This actually runs the above commands using unix system defined program (in this case it will be the terminal)
        cd(char(identifier(6))); % Changes the directory back into the DEFAULT OUTPUT PATH

        %---Creates a string that calls on James Dickson's sh python script with input _petDirect2mri.mat.nii;
        % then a matlab matrix file mri2atlas_files and with the iterated subject specific folder as the output directory. 
        % In addition since, this code is inherently slow (blame SPM), the ouput is supressed 
        % with > /dev/null 2>&1 to prevent python deprecation errors and among other useless console output
        %
        % In future, this section of the code might be re-written to increase the effiency as, this is the true bottleneck so far! 

        spm4D = strcat('sh spm_normalize_write.sh --source',{' '}, char(fullfile(folders(p), strcat(subject_id(p), '_petDirect2mri.mat.nii'))) ,' --mat',{' '}, char(mri2atlas_files{p}),' --outdir',{' '}, char(folders(p)), '> /dev/null 2>&1');
        unix(char(spm4D)); % This actually runs the above commands using unix system defined program (in this case it will be the terminal)
        cd(char(folders(p))); % Changes the directory in to the iterated subject specific folder

        %---------------------------------------------------------------------------------------------    

        re_zip1 = strcat('gzip',{' '}, subject_id(p), '_petDirect2mri.mat.nii'); % Since, SPM unzips the zipped files; this creates a string containing command for .gz compression 
        unix(char(re_zip1)); % This actually runs the above commands using unix system defined program (in this case it will be the terminal)
        re_zip2 = strcat('gzip',{'  w'}, subject_id(p), '_petDirect2mri.mat.nii'); % This creates a string containing command for .gz compression of the newly created w prefix file through SPM
        unix(char(re_zip2)); % This actually runs the above commands using unix system defined program (in this case it will be the terminal)

        %   re_zip1 = gzip(strcat(char(subject_id(p)),'_petDirect2mri.mat.nii')); % MATLAB IN-BUILT GZIP; WEIRDLY DOES NOT REMOVE THE ORIGNAL AFTER ZIPPING
        %   re_zip2 = gzip(strcat('w',char(subject_id(p)),'_petDirect2mri.mat.nii')); % MATLAB IN-BUILT GZIP; WEIRDLY DOES NOT REMOVE THE ORIGNAL AFTER ZIPPING

        cd(char(identifier(6))); % Changes the directory back into the DEFAULT OUTPUT PATH
        
        percentDone = 100*(p/numel(folders)); % Console based progress bar; much faster than the waitbar
        toc_seconds = toc; % records the toc based seconds in a variable named toc_seconds
        toc_minutes = toc_seconds/60; % Converst toc_seconds into minutes
        toc_min_int = floor(toc_minutes); % Keeps only the integer value of the recently created duration_minutes
        toc_sec_deci = ceil((toc_minutes - toc_min_int)*60); % Converts the remaining decimals into seconds
        
        ETR_seconds = seconds - toc_seconds; % Estimated Time Remaining second
        ETR_minutes = ETR_seconds/60; % Converst ETR_seconds into minutes
        ETR_min_int = floor(ETR_minutes); % Keeps only the integer value of the recently created duration_minutes
        ETR_sec_deci = ceil((ETR_minutes - ETR_min_int)*60); % Converts the remaining decimals into seconds
        
        if isequal(p,1)
            empty_string = repmat(sprintf('\b'), 1, 32);  % Erases all the content over and over again to give the allusion of updating percentage and time
        end
        message1 = sprintf('\n\n\t\t\t\t\tFSL & SPM Transformations: %3.1f', percentDone); % Creates a tabbed FSL AND SPM Transformations with 4-point precision percentage
        message2 = sprintf('\n\n\t\t\t      Estimated Time Remaining: %4.1f', ETR_min_int); % Creates tabbed Time Remaining on the next line with 4-point precision minutes
        message3 = sprintf('%5.1f',ETR_sec_deci); % Creates on the same line as above but with 5-point precision seconds
        message4 = sprintf('\n\n\t\t\t\t Actual Time Elapsed: %4.1f',toc_min_int'); % Creates a tabbed Actual Time Elapsed on the next line with 4-point precision toc minutes
        message5 = sprintf('%5.1f',toc_sec_deci); % Creates on the same line as above with 5-point precision toc seconds
        fprintf([empty_string, message1, ' %%', message2, ' minutes' , message3 , ' seconds', message4, ' minutes', message5, ' seconds']); % Displays all of the above in the command window
        empty_string = repmat(sprintf('\b'), 1, 155);  % Erases all the content over and over again to give the allusion of updating percentage and time
    end
    main = 0; % Smooth sailing
end


                          %************_______________UNDER CONSTRUCTION!________________********************

                            %************_______________TIME CORRECTION________________********************

    %         if ~exist('A09_AcquisitionTimeCorrection','file') % Checks whether or not the folder names 'A09_AcquisitionTimeCorrection' already exists
    %         AcquisitionTimeCorrection = mkdir('A09_AcquisitionTimeCorrection'); % If boolean false, this folder is created in the DEFAULT OUTPUT PATH
    %         end
  
                               % PROBBLEM WITH THE DATA; NEITHER A09 or A07 seem to have 4 dimensions...
                               
      
bye = {'Adiós', 'Adieu', 'Adeus', 'Aloha', 'Arrivederci', 'Ciao', 'Auf Wiedersehen', 'Au revoir', 'Bon voyage', 'Sayonara', 'Zàijiàn'}; % Cell array of different farewell greetings
byebye = bye(round((10).*rand(1,1) + 1)); % randomly picks one of the farewell greetings above
fprintf(strcat('\n\n [\b',char(byebye),'...]\b\n\n\n\n')); % displays the picked farewell greeting    

%____________EXIT ASCII ANIMATION FRAMES____________%

 M1 =  '     <!>>><<<!>                            '; % FRAME 1
 M2 =  '      /  00  \  @                          ';
 M3 =  '     .~~~~~~~~./                           ';
 M4 =  '    /! --  -- !                            ';
 M5 =  '   @ !___--___!                            ';
 M6 =  '     |        |                            ';
 M7 =  '     ^        ^                            ';

 M8 =  '         <)>>><<<(>                        '; % FRAME 2
 M9 =  '          /  00  \                         ';
 M10 = '         .~~~~~~~~.___@                    ';
 M11 = '        /! --  -- !                        ';
 M12 = '       @ !___--___!                        ';
 M13 = '         |        |                        ';
 M14 = '         ^        ^                        ';

 M15 = '     <---^^--->                            '; % FRAME 3
 M16 = '      /  00  \                             ';
 M17 = ' @___. ~~~~~~~.                            ';
 M18 = '     ! --   --! \                          ';
 M19 = '     !___--___!  @                         ';
 M20 = '     |        |                            ';
 M21 = '      ^        ^                           ';
 
 M22 = '            <^--^^--^>                     '; % FRAME 4
 M23 = '             /  00  \                      ';
 M24 = '        @____ ~~~~~~~~                     ';
 M25 = '            ! --  -- !\                    ';
 M26 = '            !___--___! @                   ';
 M27 = '           /        /                      ';
 M28 = '           ^         ^                     ';
 
 M29 = '                   <!>>><<<!>              '; % FRAME 5
 M30 = '                    /  00  \               ';
 M31 = '                   ~~~~~~~~                ';
 M32 = '                 / ! --  -- !\             ';
 M33 = '                   !___--___! @            ';
 M34 = '                  /        /               ';
 M35 = '                 ^         ^               ';
 
  %________________________________________________%


BYE = vertcat(M1,M2,M3,M4,M5,M6,M7); % Vertically Concates FRAME 1's individual "M" parts into a single matrix
BYE2 = vertcat(M8,M9,M10,M11,M12,M13,M14); % Vertically Concates FRAME 2's individual "M" parts into a single matrix
BYE3 = vertcat(M15,M16,M17,M18,M19,M20,M21); % Vertically Concates FRAME 3's individual "M" parts into a single matrix
BYE4 = vertcat(M22,M23,M24,M25,M26,M27,M28); % Vertically Concates FRAME 4's individual "M" parts into a single matrix
BYE5 = vertcat(M29,M30,M31,M32,M33,M34,M35); % Vertically Concates FRAME 5's individual "M" parts into a single matrix
fprintf('\n\n\n'); % Creates three new line to give the animation more space and be displayed in a better looking manner

for i = 1:5 % The animation loop to replay the animation for a desired number of times (currently set to 5 times)
    disp(BYE); % Displays the whole FRAME 1 
    pause(0.3) % Pauses 0.3 seconds before deleting the frame, i.e. this is how animation works by tricking the human eye
    fprintf(repmat(sprintf('\b'), 1, 308)); % Deletes the whole FRAME 1 
    disp(BYE2); % Displays the whole FRAME 2 
    pause(0.3) % Pauses 0.3 seconds before deleting the frame
    fprintf(repmat(sprintf('\b'), 1, 308)); % Deletes the whole FRAME 2 
    disp(BYE3); % Displays the whole FRAME 3 
    pause(0.3) % Pauses 0.3 seconds before deleting the frame
    fprintf(repmat(sprintf('\b'), 1, 308)); % Deletes the whole FRAME 3 
    disp(BYE4); % Displays the whole FRAME 4 
    pause(0.3) % Pauses 0.3 seconds before deleting the frame
    fprintf(repmat(sprintf('\b'), 1, 308)); % Deletes the whole FRAME 4 
    disp(BYE5); % Displays the whole FRAME 5 
    pause(0.3) % Pauses 0.3 seconds before deleting the frame
    fprintf(repmat(sprintf('\b'), 1, 308)); % Deletes the whole FRAME 5 
end
fprintf('\n\n'); % Inserts two newlines after the end of animation, merely for asthetics!
    
%--------------
clear all     %| Memory cleaning block
clear classes %| flushes out everything
clear clc     %| including java, classes
clear java    %| and command window...
%--------------    
