<%@ page contentType="text/html;charset=UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/upload/css/style.css" />

<div id="frame" class="updiv">
 
	<script src="${ctx }/upload/js/resumable.js"></script>

	<div class="resumable-error">
		Your browser, unfortunately, is not supported by Resumable.js. The
		library requires support for <a href="http://www.w3.org/TR/FileAPI/">the
			HTML5 File API</a> along with <a
			href="http://www.w3.org/TR/FileAPI/#normalization-of-params">file
			slicing</a>.
	</div>

	<div class="resumable-drop"
		ondragenter="jQuery(this).addClass('resumable-dragover');"
		ondragend="jQuery(this).removeClass('resumable-dragover');"
		ondrop="jQuery(this).removeClass('resumable-dragover');">
		<a class="resumable-browse"><u>文件上传</u> </a>
	</div>

	<div class="resumable-progress">
		<table>
			<tr>
				<td width="100%"><div class="progress-container">
						<div class="progress-bar" ></div>
					</div>
				</td>
				<td class="progress-text" nowrap="nowrap"></td>
				<td class="progress-pause" nowrap="nowrap"><a href="#"
					onclick="r.upload(); return(false);" class="progress-resume-link"><img
						src="${ctx}/upload/img/resume.png" title="Resume upload" /> </a> <a href="#"
					onclick="r.pause(); return(false);" class="progress-pause-link"><img
						src="${ctx}/upload/img/pause.png" title="Pause upload" /> </a></td>
			</tr>
		</table>
	</div>

	<ul class="resumable-list"></ul>

	<script>
	    var isNext=false;
		var r = new Resumable({
			target : '${ctx}/Upload',
			chunkSize : 1 * 1024 * 1024,
			simultaneousUploads : 4,
			testChunks : true,
			throttleProgressCallbacks : 1,
			method : "octet"
		});
		if (!r.support)
			location.href = '/some-old-crappy-uploader';
		//拖拽
		r.assignBrowse(document.getElementById('frame'));
		r.assignDrop(document.getElementById('frame'));
		// Resumable.js isn't supported, fall back on a different method
		if (!r.support) {
			$('.resumable-error').show();
		} else {
			// Show a place for dropping/selecting files
			$('.resumable-drop').show();
			r.assignDrop($('.resumable-drop')[0]);
			r.assignBrowse($('.resumable-browse')[0]);

			// Handle file add event
			r.on('fileAdded',function(file) {
								// Show progress pabr
								$('.resumable-progress, .resumable-list')
										.show();
								// Show pause, hide resume
								$('.resumable-progress .progress-resume-link')
										.hide();
								$('.resumable-progress .progress-pause-link')
										.show();
							    //验证文件类型
							    checkType(file.fileName);
								// Add the file to the list
								$('.resumable-list')
										.append(
												'<li class="resumable-file-'+file.uniqueIdentifier+'">上传文件 <span class="resumable-file-name"></span> <span class="resumable-file-progress"></span>');
								$(
										'.resumable-file-'
												+ file.uniqueIdentifier
												+ ' .resumable-file-name')
										.html(file.fileName);
								// Actually start the upload
								if(isNext){
								r.upload();
								}else{
								alert("不支持你所上传的文件类型，请重新选择！");
								}
								
							});
			r.on('pause', function() {
				// Show resume, hide pause
				$('.resumable-progress .progress-resume-link').show();
				$('.resumable-progress .progress-pause-link').hide();
			});
			r
					.on(
							'complete',
							function() {
								// Hide pause/resume when the upload has completed
								$(
										'.resumable-progress .progress-resume-link, .resumable-progress .progress-pause-link')
										.hide();
							});
			r.on('fileSuccess', function(file, message) {
				// Reflect that the file upload has completed

				$(
						'.resumable-file-' + file.uniqueIdentifier
								+ ' .resumable-file-progress').html(message);
								
								$("#fileupload").val(message.substring(message.indexOf(",")+1));
								$("#upresult").val(message.substring(0,message.indexOf(",")));
								if(r.progress()>=1){
				                  $("#fileupload").val('转码中...');
				                  $("#fileupload").css('color','red');
				                }
							    if(message!="Upload..."){
								 alert("上传成功！");
								 $("#fileupload").val(message.substring(message.indexOf(",")+1));
								 $("#fileupload").css('color','black');
								}
								 
			});
			r.on('fileError', function(file, message) {
				// Reflect that the file upload has resulted in error
				$(
						'.resumable-file-' + file.uniqueIdentifier
								+ ' .resumable-file-progress').html(
						'(file could not be uploaded: ' + message + ')');
			});
			r.on('fileProgress', function(file) {
				// Handle progress for both the file and the overall upload
				$(
						'.resumable-file-' + file.uniqueIdentifier
								+ ' .resumable-file-progress').html(
						Math.floor(file.progress() * 100) + '%');
				$('.progress-bar').css({
					width : Math.floor(r.progress() * 100) + '%'
				});
				
			});
		}
		function checkType(filepath){
		var filetypes =[".jpg",".png",".rar",".txt",".zip",".doc",".ppt",".xls",".pdf",".docx",".xlsx",".mp3",".mp4"]; 
		 
        var fileend = filepath.substring(filepath.indexOf(".")); 
        if(filetypes.length>0){
        for(var i=0;i<filetypes.length;i++){
           if(fileend==filetypes[i]){
            isNext = true;
            break;
           }
         }
        }
		}
	</script>

</div>
