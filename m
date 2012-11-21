From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 11:24:34 +0100
Message-ID: <50ACABE2.2020306@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020601080502010808050300"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44312 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2KUKYi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 05:24:38 -0500
In-Reply-To: <50ABF09C.8040303@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601080502010808050300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/20/2012 10:05 PM, Wolfgang Grandegger wrote:
> Hi Michael,
> 
> On 11/20/2012 08:12 PM, Michael Pellegrini wrote:
>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>
>>>>
>>>> However, everything isn't fixed yet.  After sending a handful of messages, 
>> the 
>>>> CAN interface hits the same problem that started this thread.  My 
>> application 
>>>> prints the error "No buffer space available" and the only way to recover is 
>> an 
>>>> interface reset via "ifconfig can0 down" followed by "ifconfig can0 up".
>>>
>>> Could you please send the output of "candump any,0:0,#FFFFFFFF" while
>>> sending the messages. Do they go out to the bus? Also "ip -d -s link
>>> show can0" would be useful.
>>
>> candump produced no output while my application was running and trying to send
>> messages.  Furthermore, the lack of output from candump suggests that messages
>> aren't being received as well.  There is another CAN device on the bus and I can
>> confirm, using a CAN monitor tool on another PC, that it is actively sending
>> messages.
>>
>> Upon starting my application, 16 messages are transmitted on the bus (confirmed
>> via the external CAN monitor tool) which candump does not report.  Then
>> transmission stops.  This lines up with the output of "ip -d -s link show can0",
>> shown below:
> 
> I'm a bit confused. Where is the application running? On this
> PCH-System? Or does an external node send messages, which are not
> received by the PCH-C_CAN?
> 
>> At startup:
>>
>> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>>     c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>     clock 50000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          0          0          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     0          0        0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     0          0        0       0       0       0
>>
>> After transmission stops:
>>
>> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>>     c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>     clock 50000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          0          0          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     0          0        0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     0          0        0       0       0       0
>>
>> After transmission stops & interface is reset:
>>
>> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>>     c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>     clock 50000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          0          0          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     0          0        0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     0          0        0       16      0       0
>>
>> The best I can tell, the 16 messages which are successfully transmitted on the
>> bus are considered dropped by the driver.
> 
> OK, we still have a problem with TX and RX, most likely with interrupts.
> Could you please send a message on the PCH-System executing
> "cansend can0 123#abcdef":
> 
> - Does "candump any,0:0,#FFFFFFFF" report anything.
> 
> - Does the message show up on the bus (visiable to another node or
>   analyser)?
> 
> - Does the interrupt count increase? Check output of /proc/interrupts.
> 
> I will prepare an instrumented driver tomorrow.

Could you please try the attached c-can-pci-v4.tar.bz2. I'm puzzled why
MSI does not get enabled. What does "lspci -vv" list for that device?

Wolfgang.



--------------020601080502010808050300
Content-Type: application/x-bzip;
 name="c-can-pci-v4.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="c-can-pci-v4.tar.bz2"

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
--------------020601080502010808050300--
