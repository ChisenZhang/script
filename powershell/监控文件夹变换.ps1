# ����Ҫ��ص��ļ��У�����ļ��б����ȴ��ڡ�
$folder = 'D:\images\'
# ����ÿ�μ�صļ��ʱ�䣬��ʱ����Ϊ1000���룬��1��
$timeout = 1000
# �����ļ�ϵͳ���Ӷ���
$FileSystemWatcher = New-Object System.IO.FileSystemWatcher $folder
# ����ļ��µ����ļ���
$FileSystemWatcher.IncludeSubdirectories = $true;
# ���˼�ص��ļ�����
$FileSystemWatcher.Filter = "*.as*";
Write-Host ���� CTRL+C ���˳����ļ��� $folder �ļ�ء�
while ($true) {
  # ����ļ����ڵ����б仯
  $result = $FileSystemWatcher.WaitForChanged('all', $timeout)
  if ($result.TimedOut -eq $false)
   {
   # ���ļ��е����ݱ仯ʱ������������ʾ
   Write-Warning ('File {0} : {1}' -f $result.ChangeType, $result.name)
   $title = ('File {0} : {1}' -f $result.ChangeType, $result.name)
   $body = ('File {0} : {1}{2}' -f $result.ChangeType, $folder,$result.name)
   # (Get-Credential).password | ConvertFrom-SecureString > mpass.txt  ���������ļ�������smt��֤���û���������
   $pw = Get-Content .\mpass.txt | ConvertTo-SecureString
   $cred = New-Object System.Management.Automation.PSCredential "noreplay@test.com", $pw
   Send-MailMessage  -To yaokuaile@kaihejia.com  -from "�ļ���� <noreplay@test.com>"  -Subject "$title" -Body "$body" -encoding ([System.Text.Encoding]::UTF8) -priority High -smtpServer smtp.test.com -Credential $cred;

   }
} 
Write-Host '��ر�ȡ��.'