From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Why doesn't the socketcan prio qdisc work for first 10 can frames?
Date: Thu, 27 Nov 2014 12:46:23 +0100
Message-ID: <54770F0F.7050904@hartkopp.net>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:33309 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbaK0Lq1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 06:46:27 -0500
In-Reply-To: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ruan TingQuan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Please try to reduce the tx queue length of the CAN netdevice to 1

E.g.

ip link set can0 txqueuelen 1

Does that help?

Regards,
Oliver

On 27.11.2014 10:43, Ruan TingQuan (ST-FIR/ENG1-Zhu) wrote:
> Hello Linux-can-team,
>
> A prio qdisc is created with 8 bands for my different priority sending requirement.
> My test environment: ubuntu 12.04 (kernel 3.11) + PEAK-USB pro (can0 is connect to can1).
> The frame will be send on can0 and receive on can1 (candump)
> Below is the setting on can0:
> 	> ip link set can0 type can bitrate 5000
> 	> ip link set can1 type can bitrate 5000
> 	> tc qdisc add dev can0 root handle 1: prio bands 8
> 	> tc filter add dev $1 parent 1:0 prio 1 basic match canid\(eff 0x1:0x7\) flowid 1:1
> 	> tc filter add dev $1 parent 1:0 prio 2 basic match canid\(eff 0x2:0x7\) flowid 1:2
> 	> tc filter add dev $1 parent 1:0 prio 3 basic match canid\(eff 0x3:0x7\) flowid 1:3
> 	> tc filter add dev $1 parent 1:0 prio 4 basic match canid\(eff 0x4:0x7\) flowid 1:4
> 	> tc filter add dev $1 parent 1:0 prio 5 basic match canid\(eff 0x5:0x7\) flowid 1:5
> 	> tc filter add dev $1 parent 1:0 prio 6 basic match canid\(eff 0x6:0x7\) flowid 1:6
> 	> tc filter add dev $1 parent 1:0 prio 7 basic match canid\(eff 0x7:0x7\) flowid 1:7
> 	> tc filter add dev $1 parent 1:0 prio 8 basic match canid\(sff 0x0:0x0 eff 0x0:0x0\) flowid 1:8
>
> Then, I made a test program to send 10 frames on can0 socket quickly.
>    	can0  81234560   [8]  00 00 00 00 50 50 50 50
>    	can0  81234567   [8]  07 07 07 07 4F 4F 4F 4F
>    	can0  81234566   [8]  06 06 06 06 4E 4E 4E 4E
>    	can0  81234565   [8]  05 05 05 05 4D 4D 4D 4D
> 	can0  81234564   [8]  04 04 04 04 4C 4C 4C 4C
>    	can0  81234563   [8]  03 03 03 03 4B 4B 4B 4B
>    	can0  81234562   [8]  02 02 02 02 4A 4A 4A 4A
>    	can0  81234561   [8]  01 01 01 01 49 49 49 49
>    	can0  81234560   [8]  00 00 00 00 48 48 48 48
>    	can0  81234567   [8]  07 07 07 07 47 47 47 47
>
> I expect the frames from can1 with priority sequence high to low:
> 	can1  01234560   [8]  00 00 00 00 50 50 50 50
> 	can1  01234561   [8]  01 01 01 01 49 49 49 49
> 	can1  01234562   [8]  02 02 02 02 4A 4A 4A 4A
> 	can1  01234563   [8]  03 03 03 03 4B 4B 4B 4B
> 	can1  01234564   [8]  04 04 04 04 4C 4C 4C 4C
> 	can1  01234565   [8]  05 05 05 05 4D 4D 4D 4D
> 	can1  01234566   [8]  06 06 06 06 4E 4E 4E 4E
> 	can1  01234567   [8]  07 07 07 07 4F 4F 4F 4F
> 	can1  01234560   [8]  00 00 00 00 48 48 48 48
>
> But actually, I got the frames with same sequence
> 	can1  01234560   [8]  00 00 00 00 50 50 50 50
> 	can1  01234567   [8]  07 07 07 07 4F 4F 4F 4F
> 	can1  01234566   [8]  06 06 06 06 4E 4E 4E 4E
> 	can1  01234565   [8]  05 05 05 05 4D 4D 4D 4D
> 	can1  01234564   [8]  04 04 04 04 4C 4C 4C 4C
> 	can1  01234563   [8]  03 03 03 03 4B 4B 4B 4B
> 	can1  01234562   [8]  02 02 02 02 4A 4A 4A 4A
> 	can1  01234561   [8]  01 01 01 01 49 49 49 49
> 	can1  01234560   [8]  00 00 00 00 48 48 48 48
> 	can1  01234567   [8]  07 07 07 07 47 47 47 47
> 	can1  01234566   [8]  06 06 06 06 46 46 46 46
>
> And I found that just happens for first 10 frames. After that, prio qdisc works fine.
> Why? Or What am I missing?
>
> Regards!
> Leo Ruan
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
