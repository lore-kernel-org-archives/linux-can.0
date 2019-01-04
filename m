From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Test results - was Re: [PATCH] can: gw: ensure DLC boundaries after
 CAN frame modification
Date: Fri, 4 Jan 2019 14:25:37 +0100
Message-ID: <241be19a-be67-8535-5496-7c896d00a99e@hartkopp.net>
References: <20190104091353.2438-1-socketcan@hartkopp.net>
 <20190104103147.GE28932@unicorn.suse.cz>
 <b0013590-fc0b-320f-3c11-9fb0deb9bb86@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b0013590-fc0b-320f-3c11-9fb0deb9bb86@hartkopp.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Michal Kubecek <mkubecek@suse.cz>, ieatmuttonchuan@gmail.com, meissner@suse.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi all,

just for the records:

I did some tests with the cangw tool from 
https://github.com/linux-can/can-utils where I removed some sanity 
checks (6,7) in parse_mod() to be able to reproduce Muyu's setup.

The filters are configured as follows:

# cangw -L
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.41.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:401.40.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.3F.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.9.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:301.8.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.7.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.41.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:201.40.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.3F.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:102.9.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:101.8.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:100.7.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 0 deleted

After sending a Classic CAN frame DLC of 1:
$ cansend vcan0 001#22

candump produces this:
$ candump -ta any
  (1546606529.898372)  vcan0  001   [1]  22
  (1546606529.898830)  vcan1  301   [8]  22 00 00 00 00 00 00 00
  (1546606529.898921)  vcan1  300   [7]  22 00 00 00 00 00 00
  (1546606529.899308)  vcan1  101   [8]  22 00 00 00 00 00 22 00
  (1546606529.899399)  vcan1  100   [7]  22 00 00 00 00 22 00

And the handled and deleted frames are counted as follows:

# cangw -L
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.41.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:401.40.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.3F.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.9.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:301.8.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.7.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.41.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:201.40.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.3F.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:102.9.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:101.8.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:100.7.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 1 handled 0 dropped 0 deleted

So all modified DLC values that did not fit into the frame lead to 
deleted CAN frames.

When sending a CAN FD frame with DLC of 1 as an alternative:
$ cansend vcan0 001##022

candump produces this:
$ candump -ta any
  (1546607375.109495)  vcan0  001  [01]  22
  (1546607375.109749)  vcan1  401  [64]  22 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00
  (1546607375.109850)  vcan1  400  [63]  22 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
  (1546607375.109949)  vcan1  300  [09]  22 00 00 00 00 00 00 00 00
  (1546607375.110049)  vcan1  301  [08]  22 00 00 00 00 00 00 00
  (1546607375.110148)  vcan1  300  [07]  22 00 00 00 00 00 00
  (1546607375.110574)  vcan1  101  [08]  22 00 00 00 00 00 22 00
  (1546607375.110674)  vcan1  100  [07]  22 00 00 00 00 22 00

And the handled and deleted frames are counted as follows:
# cangw -L
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.41.0000000000000000 -f 
001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:401.40.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:400.3F.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.9.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:301.8.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:300.7.0000000000000000 -f 
001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.41.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:201.40.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:200.3F.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:102.9.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 0 handled 0 dropped 1 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:101.8.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 1 handled 0 dropped 0 deleted
cangw -A -s vcan0 -d vcan1 -e -m SET:IL:100.7.0000000000000000 -x 
-6:0:-2:00 -f 001:C00007FF # 1 handled 0 dropped 0 deleted

Here you can see the additional effect of deleting frames with a dlc > 8 
that are configured to calculate a checksum.

So finally all new code paths of the patch have been triggered and do 
the intended stuff.

Best regards,
Oliver
