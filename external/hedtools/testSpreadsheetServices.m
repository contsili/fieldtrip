function errors = testSpreadsheetServices(host)
%% Shows how to call hed-services to process a spreadsheet of event tags.
% 
%  Example 1: Validate valid spreadsheet file using schema version.
%
%  Example 2: Validate invalid spreadsheet file using HED URL.
%
%  Example 3: Convert valid spreadsheet file to long uploading HED schema.
%
%  Example 4: Convert valid spreadsheet file to short using HED version.
%
%% Get the options and data
[servicesUrl, options] = getHostOptions(host);
data = getTestData();
errors = {};

%% Example 1: Validate valid spreadsheet file using schema version.
request1 = struct('service', 'spreadsheet_validate', ...
                  'schema_version', '8.0.0', ...
                  'spreadsheet_string', data.spreadsheetText, ...
                  'check_for_warnings', 'on', ...
                  'has_column_names', 'on', ...
                  'column_1_input', data.labelPrefix, ...
                  'column_1_check', 'on', ...
                  'column_4_input', '', ...
                  'column_4_check', 'on');
response1 = webwrite(servicesUrl, request1, options);
response1 = jsondecode(response1);
outputReport(response1, 'Example 1 validate a valid spreadsheet');

if ~isempty(response1.error_type) || ...
   ~strcmpi(response1.results.msg_category, 'success')
   errors{end + 1} = ...
       'Example 1 failed to validate a correct spreadsheet file.';
end

%% Example 2: Validate invalid spreadsheet file using HED URL.
request2 = struct('service', 'spreadsheet_validate', ...
                  'schema_url', data.schemaUrl, ...
                  'spreadsheet_string', data.spreadsheetTextInvalid, ...
                  'check_for_warnings', 'on', ...
                  'has_column_names', 'on', ...
                  'column_1_input', 'Event/Label/', ...
                  'column_1_check', 'on', ...
                  'column_4_input', '', ...
                  'column_4_check', 'on');
response2 = webwrite(servicesUrl, request2, options);
response2 = jsondecode(response2);
outputReport(response2, 'Example 2 validate an invalid spreadsheet');
if ~isempty(response2.error_type) || ...
   ~strcmpi(response2.results.msg_category, 'warning')
   errors{end + 1} = ...
       'Example 2 failed to detect an incorrect spreadsheet file.';
end

%% Example 3: Convert valid spreadsheet file to long uploading HED schema.
request3 = struct('service', 'spreadsheet_to_long', ...
                  'schema_string', data.schemaText, ...
                  'spreadsheet_string', data.spreadsheetText, ...
                  'expand_defs', 'on', ...
                  'has_column_names', 'on', ...
                  'column_1_input', data.labelPrefix, ...
                  'column_1_check', 'on', ...
                  'column_3_input', data.descPrefix, ...
                  'column_3_check', 'on', ...
                  'column_4_input', '', ...
                  'column_4_check', 'on');
response3 = webwrite(servicesUrl, request3, options);
response3 = jsondecode(response3);
outputReport(response3, 'Example 3 convert a spreadsheet to long form');
results = response3.results;
if ~isempty(response3.error_type) || ...
   ~strcmpi(response3.results.msg_category, 'success')
   errors{end + 1} = ...
'Example 3 failed to convert a spreadsheet file to long.';
end

%% Example 4: Convert valid spreadsheet file to short using uploaded HED.
request4 = struct('service', 'spreadsheet_to_short', ...
                  'schema_string', data.schemaText, ...
                  'spreadsheet_string', data.spreadsheetText, ...
                  'expand_defs', 'on', ...
                  'has_column_names', 'on', ...
                  'column_1_input', data.labelPrefix, ...
                  'column_1_check', 'on', ...
                  'column_3_input', data.descPrefix, ...
                  'column_3_check', 'on', ...
                  'column_4_input', '', ...
                  'column_4_check', 'on');
response4 = webwrite(servicesUrl, request4, options);
response4 = jsondecode(response4);
outputReport(response4, 'Example 4 convert a spreadsheet to short form');
if ~isempty(response4.error_type) || ...
   ~strcmpi(response4.results.msg_category, 'success')
   errors{end + 1} = ...
       'Example 4 failed to convert a spreadsheet file to short.';
end

