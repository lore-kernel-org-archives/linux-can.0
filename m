From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Flooding AT91_CAN peripheral with messages causes it to stop
 receiving any more messages
Date: Fri, 29 Apr 2016 13:18:34 +0200
Message-ID: <5723430A.50009@grandegger.com>
References: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
 <57076043.1080609@grandegger.com>
 <CAOLz05qjUh0Ovtrs-NK3_RjNWc6X+gAo6=YpXODZU_n5A04eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:38131 "EHLO
	mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbcD2LSi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 29 Apr 2016 07:18:38 -0400
In-Reply-To: <CAOLz05qjUh0Ovtrs-NK3_RjNWc6X+gAo6=YpXODZU_n5A04eVw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amr Bekhit <amrbekhit@gmail.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org

Hello Amr,

is function tracing (ftrace) working on your system?

Wolfgang.

Am 29.04.2016 um 10:04 schrieb Amr Bekhit:
> Hello,
>
> Thanks to both of you for your responses.
>
> @Menchel: From my observations, the problem is when you have several
> CAN packets that are sent in quick succession. I initially started
> seeing this problem while trying to interface my embedded board to a
> 3rd party CAN device. The CAN device only sent 10 messages every
> second at 100kBaud (so not a huge amount of traffic), but they were
> all sent in one burst, one immediately after the other. If I modify my
> test script to send the CAN messages with a 5ms delay in between, I
> don't seem to have this problem.
>
> @Wolfgang: The CPU is an AT91SAM9X25 SoC running at 400Mhz.
>
> I've carried out another test where I've run "canfdtest -vv -g can0"
> on a host PC with a PCAN-USB device attached and "canfdtest -vv can0"
> on the embedded device and let it run overnight (from 5pm till 8.30am
> the following day). At the end of the test, the host PC had stopped
> sending any more data (there was no more terminal output indicating
> that bytes had been sent) and likewise, the embedded system was not
> receiving any data.
>
> (As a side note, I could not Ctrl-C out of the running canfdtest on
> the embedded system - I ended up having to SSH into the embedded
> system to get access to another terminal so I could run some commands
> - only kill -9 would kill the process)
>
> Even after killing and restarting the canfdtest processes on both host
> and embedded computers, no can messages were sent. I had to bring the
> interface down then back up again on the embedded system before the
> two programs starting showing that messages were being sent and
> recevied.
>
> I've run the following commands on the embedded system at the end of the test:
>
> # cat /proc/interrupts
>             CPU0
>   16:  102823451  atmel-aic   1 Level     pmc, at91_tick, ttyS0
>   17:          0       PMC  17 Level     main_rc_osc
>   18:          0       PMC   0 Level     main_osc
>   19:          0       PMC  16 Level     mainck
>   20:          0       PMC   1 Level     clk-plla
>   21:          1       PMC   6 Level     clk-utmi
>   22:          0       PMC   3 Level     clk-master
>   23:    7352177  atmel-aic  17 Level     tc_clkevt
>   24:      24128  atmel-aic  20 Level     at_hdmac
>   25:          0  atmel-aic  21 Level     at_hdmac
>   29:         42  atmel-aic  12 Level     f0008000.mmc
>   32:    3134371  atmel-aic   9 Level     f8010000.i2c
>   34:          3  atmel-aic  16 Level     ttyS6
>   35:          0  atmel-aic  19 Level     at91_adc
>   36:       6881  atmel-aic  13 Level     f0000000.spi
>   37:          0  atmel-aic  23 Level     atmel_usba_udc
>   39:          0  atmel-aic  24 Level     eth0
>   40:    4952869  atmel-aic  30 Level     can0
>   41:     348546  atmel-aic  22 Level     ehci_hcd:usb1, ohci_hcd:usb2
>   90:          0      GPIO  16 Edge      atmel_usba_udc
> 140:          0      GPIO  15 Edge      mmc-detect
> Err:          0
>
> # ifconfig can0
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>            UP RUNNING NOARP  MTU:16  Metric:1
>            RX packets:2476577 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:2476527 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:10
>            RX bytes:19812616 (18.8 MiB)  TX bytes:19812216 (18.8 MiB)
>            Interrupt:40
>
> # ip -details -statistics link show can0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
> UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
>            bitrate 99950 sample-point 0.739
>            tq 435 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>            at91_can: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 2..128 brp-inc 1
>            clock 133333333
>            re-started bus-errors arbit-lost error-warn error-pass bus-off
>            0          0          0          0          0          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      19812616   2476577  0       0       0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      19812216   2476527  0       0       0       0
>
> I did another dump of the can peripheral register memory after the
> test. Here are the results:
>
> Dumping memory from 0xF8004000 to 0xF8004000:
> 0xF8004000: [00000001] 0000 0000 0000 0000 0000 0000 0000 0001
> 0xF8004004: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004008: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF800400C: [1F040038] 0001 1111 0000 0100 0000 0000 0011 1000
> 0xF8004010: [006000C7] 0000 0000 0110 0000 0000 0000 1100 0111
> 0xF8004014: [00390775] 0000 0000 0011 1001 0000 0111 0111 0101
> 0xF8004018: [0000B2E4] 0000 0000 0000 0000 1011 0010 1110 0100
> 0xF800401C: [000052D3] 0000 0000 0000 0000 0101 0010 1101 0011
> 0xF8004020: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004024: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004028: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF80040E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF80040E8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF8004200: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
> 0xF8004204: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004208: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF800420C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004210: [01885139] 0000 0001 1000 1000 0101 0001 0011 1001
> 0xF8004214: [21201F1E] 0010 0001 0010 0000 0001 1111 0001 1110
> 0xF8004218: [25242322] 0010 0101 0010 0100 0010 0011 0010 0010
> 0xF800421C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF8004220: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
> 0xF8004224: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004228: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF800422C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004230: [018851AD] 0000 0001 1000 1000 0101 0001 1010 1101
> 0xF8004234: [2221201F] 0010 0010 0010 0001 0010 0000 0001 1111
> 0xF8004238: [26252423] 0010 0110 0010 0101 0010 0100 0010 0011
> 0xF800423C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF8004240: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
> 0xF8004244: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004248: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF800424C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004250: [008852D3] 0000 0000 1000 1000 0101 0010 1101 0011
> 0xF8004254: [23222120] 0010 0011 0010 0010 0010 0001 0010 0000
> 0xF8004258: [27262524] 0010 0111 0010 0110 0010 0101 0010 0100
> 0xF800425C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF8004260: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
> 0xF8004264: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004268: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF800426C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004270: [00084FD9] 0000 0000 0000 1000 0100 1111 1101 1001
> 0xF8004274: [201F1E1D] 0010 0000 0001 1111 0001 1110 0001 1101
> 0xF8004278: [24232221] 0010 0100 0010 0011 0010 0010 0010 0001
> 0xF800427C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF8004280: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
> 0xF8004284: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004288: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF800428C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF8004290: [000876D4] 0000 0000 0000 1000 0111 0110 1101 0100
> 0xF8004294: [78777675] 0111 1000 0111 0111 0111 0110 0111 0101
> 0xF8004298: [7C7B7A79] 0111 1100 0111 1011 0111 1010 0111 1001
> 0xF800429C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF80042A0: [02000000] 0000 0010 0000 0000 0000 0000 0000 0000
> 0xF80042A4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF80042A8: [20000000] 0010 0000 0000 0000 0000 0000 0000 0000
> 0xF80042AC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF80042B0: [0008C8D2] 0000 0000 0000 1000 1100 1000 1101 0010
> 0xF80042B4: [05040302] 0000 0101 0000 0100 0000 0011 0000 0010
> 0xF80042B8: [09080706] 0000 1001 0000 1000 0000 0111 0000 0110
> 0xF80042BC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF80042C0: [03070000] 0000 0011 0000 0111 0000 0000 0000 0000
> 0xF80042C4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF80042C8: [01E00000] 0000 0001 1110 0000 0000 0000 0000 0000
> 0xF80042CC: [00000078] 0000 0000 0000 0000 0000 0000 0111 1000
> 0xF80042D0: [00885220] 0000 0000 1000 1000 0101 0010 0010 0000
> 0xF80042D4: [F2F1F0EF] 1111 0010 1111 0001 1111 0000 1110 1111
> 0xF80042D8: [F6F5F4F3] 1111 0110 1111 0101 1111 0100 1111 0011
> 0xF80042DC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> 0xF80042E0: [03060000] 0000 0011 0000 0110 0000 0000 0000 0000
> 0xF80042E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
> 0xF80042E8: [01E00000] 0000 0001 1110 0000 0000 0000 0000 0000
> 0xF80042EC: [00000078] 0000 0000 0000 0000 0000 0000 0111 1000
> 0xF80042F0: [008850C3] 0000 0000 1000 1000 0101 0000 1100 0011
> 0xF80042F4: [F1F0EFEE] 1111 0001 1111 0000 1110 1111 1110 1110
> 0xF80042F8: [F5F4F3F2] 1111 0101 1111 0100 1111 0011 1111 0010
> 0xF80042FC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>
> On 8 April 2016 at 08:39, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Hello,
>>
>>
>> Am 05.04.2016 um 15:10 schrieb Amr Bekhit:
>>>
>>> Hello,
>>>
>>> <Sorry for the re-send. I initially sent this as HTML, but then found
>>> out that it was recommended to send all emails as plaintext, hence the
>>> resend>
>>>
>>> I working on a board based on the AT91SAM9X25 SoC and I'm using
>>> integrated CAN peripheral. I seem to have run into an issue whereby
>>> sending lots of messages very rapidly in quick succession causes the
>>> CAN peripheral to then stop receiving any messages at all. The only
>>> way to bring it back to a functional state is to bring the network
>>> interface down and then back up again.
>>>
>>> The problem can be replicated as follows:
>>>
>>> The CAN interface is initialised using:
>>>
>>> ip link set can0 type can bitrate 100000 restart-ms 100
>>> ifconfig can0 up
>>>
>>> I then start sending CAN messages to the unit using a PCAN-USB adapter
>>> that is plugged into a test Linux PC. After bringing up the CAN
>>> interface on the test PC, messages can be continuously sent using the
>>> following bash script:
>>>
>>> #!/bin/bash
>>>
>>> while :
>>> do
>>> cansend can0 123#DEADBEEFDEADBEEF
>>> done
>>>
>>> After running the script, I check that messages are being received on
>>> the AT91 target by running
>>>
>>> ifconfig can0
>>>
>>> and checking that the number of received packets is increasing.
>>>
>>> I then leave the system running for some time (1.5 hours typically,
>>> may vary), periodically running ifconfig can0 to check to see if new
>>> packets are being received. After a while, the can interface will stop
>>> receiving new packets, even though the test PC is still transmitting
>>> them. Stopping and restarting the CAN transmissions on the test PC
>>> does not solve the problem. The interface does not appear to be in the
>>> bus off state, as shown by running the following:
>>>
>>> # ip -details -statistics link show can0
>>> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
>>> UNKNOWN mode DEFAULT group default qlen 10
>>>       link/can  promiscuity 0
>>>       can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
>>>             bitrate 99950 sample-point 0.739
>>>             tq 435 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
>>>             at91_can: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 2..128 brp-inc 1
>>>             clock 133333333
>>>             re-started bus-errors arbit-lost error-warn error-pass bus-off
>>>             0          0          0          0          0          0
>>>       RX: bytes  packets  errors  dropped overrun mcast
>>>       12609768   1576221  5       0       5       0
>>>       TX: bytes  packets  errors  dropped carrier collsns
>>>       0          0        0       0       0       0
>>>
>>>
>>> # ifconfig can0
>>> can0      Link encap:UNSPEC  HWaddr
>>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>>             UP RUNNING NOARP  MTU:16  Metric:1
>>>             RX packets:1576221 errors:5 dropped:0 overruns:0 frame:5
>>>             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>             collisions:0 txqueuelen:10
>>>             RX bytes:12609768 (12.0 MiB)  TX bytes:0 (0.0 B)
>>>             Interrupt:40
>>>
>>> Using the devmem command line program and a custom python script, I
>>> dumped the contents of the CAN peripheral registers to a file. When
>>> the AT91 CAN peripheral is in the failed state, here is what the
>>> peripheral memory looks like:
>>>
>>> Dumping memory from 0xF8004000 to 0xF8004000:
>>> 0xF8004000: [00000001] 0000 0000 0000 0000 0000 0000 0000 0001
>>> 0xF8004004: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004008: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF800400C: [1F040000] 0001 1111 0000 0100 0000 0000 0000 0000
>>> 0xF8004010: [20E000FF] 0010 0000 1110 0000 0000 0000 1111 1111
>>> 0xF8004014: [00390775] 0000 0000 0011 1001 0000 0111 0111 0101
>>> 0xF8004018: [000090EF] 0000 0000 0000 0000 1001 0000 1110 1111
>>> 0xF800401C: [00009C81] 0000 0000 0000 0000 1001 1100 1000 0001
>>> 0xF8004020: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004024: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004028: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF80040E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80040E8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF8004200: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
>>> 0xF8004204: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004208: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF800420C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF8004210: [01881273] 0000 0001 1000 1000 0001 0010 0111 0011
>>> 0xF8004214: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF8004218: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF800421C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF8004220: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
>>> 0xF8004224: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004228: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF800422C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF8004230: [018812E6] 0000 0001 1000 1000 0001 0010 1110 0110
>>> 0xF8004234: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF8004238: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF800423C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF8004240: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
>>> 0xF8004244: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004248: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF800424C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF8004250: [01881359] 0000 0001 1000 1000 0001 0011 0101 1001
>>> 0xF8004254: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF8004258: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF800425C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF8004260: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
>>> 0xF8004264: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004268: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF800426C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF8004270: [018813CC] 0000 0001 1000 1000 0001 0011 1100 1100
>>> 0xF8004274: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF8004278: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF800427C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF8004280: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
>>> 0xF8004284: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF8004288: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF800428C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF8004290: [0188143F] 0000 0001 1000 1000 0001 0100 0011 1111
>>> 0xF8004294: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF8004298: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF800429C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF80042A0: [02000000] 0000 0010 0000 0000 0000 0000 0000 0000
>>> 0xF80042A4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042A8: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
>>> 0xF80042AC: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
>>> 0xF80042B0: [0188E950] 0000 0001 1000 1000 1110 1001 0101 0000
>>> 0xF80042B4: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF80042B8: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
>>> 0xF80042BC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF80042C0: [03000000] 0000 0011 0000 0000 0000 0000 0000 0000
>>> 0xF80042C4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042C8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042CC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042D0: [00800000] 0000 0000 1000 0000 0000 0000 0000 0000
>>> 0xF80042D4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042D8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042DC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> 0xF80042E0: [03000000] 0000 0011 0000 0000 0000 0000 0000 0000
>>> 0xF80042E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042E8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042EC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042F0: [00800000] 0000 0000 1000 0000 0000 0000 0000 0000
>>> 0xF80042F4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042F8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>> 0xF80042FC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
>>>
>>> I noticed that the RBSY flag is set, even though there was nothing
>>> transmitted to the CAN bus. All of the message boxes had data inside
>>> ready to be retrieved.
>>>
>>> If there are any other test you would like me to carry out, just let me
>>> know.
>>
>>
>> Where did your Linux kernel come from and what version are you using? Also
>> interesting is:
>>
>> - how fast is your CPU (frequency)?
>> - the output of "/proc/interrrupts".
>> - run "candump any,0:0,#FFFFFFFF" on the AT91 while the test is running
>> - use "cangen" or even better "canfdtest" for testing.
>>
>> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
