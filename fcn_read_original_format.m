
function imRGB = fcn_read_original_format(input_folder, filename, stack_number)


        [~,image_name,fmt] = fileparts(filename);    

        strInput = [input_Folder filename];
        reader = bfGetReader(strInput);
        
        if strcmp(fmt,'vsi')
            reader.setId([input_folder '_' image_name '_\stack1\frame_t.ets']);
        end
    
        j=stack_number;
        reader.setSeries(j-1);
    % 
        if reader.getImageCount()==3
    
            omeMeta = reader.getMetadataStore();
            image_width = omeMeta.getPixelsSizeX(j-1).getValue; % image width, pixels
            image_height = omeMeta.getPixelsSizeY(j-1).getValue; % image height, pixels
    
            max = 2e9;
            tile_width = floor(max / image_height); %% no of col
            tile_height = image_height; %% no of row
            number_of_tile = ceil(image_width / tile_width);
            tile_width_last = mod(image_width, tile_width);
            imRGB = [];
    
            iZ = 1; iC1 = 1; iC2 = 2; iC3 = 3; iT = 1;
            for tile_index = 1:number_of_tile
                disp(['processing ' image_name '_' num2str(tile_index) ' tile'])
                if tile_index ~= number_of_tile
                    iPlane = reader.getIndex(iZ - 1, iC1 -1, iT - 1) + 1;
                    I1 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width,tile_height);%origin is the top left corner(origin-col,origin-row,box-col,box-row)
                    iPlane = reader.getIndex(iZ - 1, iC2 -1, iT - 1) + 1;
                    I2 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width,tile_height);
                    iPlane = reader.getIndex(iZ - 1, iC3 -1, iT - 1) + 1;
                    I3 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width,tile_height);
                else
                    iPlane = reader.getIndex(iZ - 1, iC1 -1, iT - 1) + 1;
                    I1 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width_last,tile_height);%origin is the top left corner(origin-col,origin-row,box-col,box-row)
                    iPlane = reader.getIndex(iZ - 1, iC2 -1, iT - 1) + 1;
                    I2 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width_last,tile_height);
                    iPlane = reader.getIndex(iZ - 1, iC3 -1, iT - 1) + 1;
                    I3 = bfGetPlane(reader, iPlane,1 + (tile_index-1)*tile_width,1,tile_width_last,tile_height);
                end
    
                imRGB_tile = cat(3, I1, I2, I3);
                imRGB = [imRGB imRGB_tile];
            end
    
            reader.close();
        end
    end
end