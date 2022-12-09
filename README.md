# How to use
## 1.安裝 ClamAV
`sudo apt install clamav`

mailutils

`sudo apt install mailutils`
## 2.下載
`git clone https://gitlab.corp.ailabs.tw/engine/clamscan.git`


## 3.執行
(視需求修改clamscan.sh內的收件人、寄件人、scan的目錄等資訊)

`cd clamscan`

`./clamscan.sh`

## 4.建立排程
於crontab建立clamav的script 執行排程

`sudo crontab -e`

`55 23 * * 5 /home/USER/clamscan/clamscan.sh`

設定每周五晚間23:55執行
