From: Karsten Aalykke Stenzhorn <Karsten.Stenzhorn@marel.com>
Subject: Using TC from iproute, unable to match canid
Date: Mon, 25 Nov 2013 16:49:02 +0000
Message-ID: <42EF5F2B19AAE545B9E5BC916D3343F770D19F1E@GRBSR0004.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:8151 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756514Ab3KYQtL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Nov 2013 11:49:11 -0500
Received: from mail67-co9 (localhost [127.0.0.1])	by mail67-co9-R.bigfish.com
 (Postfix) with ESMTP id 84427E0264	for <linux-can@vger.kernel.org>; Mon, 25
 Nov 2013 16:49:10 +0000 (UTC)
Received: from CO9EHSMHS030.bigfish.com (unknown [10.236.132.252])	by
 mail67-co9.bigfish.com (Postfix) with ESMTP id 369253C0111	for
 <linux-can@vger.kernel.org>; Mon, 25 Nov 2013 16:49:07 +0000 (UTC)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I'm trying to use tc from iproute2 to prioritize packets sent to a canb=
us.

Before doing so I read this guide about the issue:=A0http://rtime.felk.=
cvut.cz/can/socketcan-qdisc-final.pdf
Even using the exact examples from that pdf, I'm not able get any of th=
e filters to get a match. My current version of kernel and tc only allo=
ws me to use the u32 match option.

Tried (both big and little endian):

tc filter add dev can0 parent 1:0 prio 1 u32 match u32 0x01000000 0xfff=
fffff at 0 flowid 1:1

and also:

tc filter add dev can0 parent 1:0 prio 1 u32 match u8 0x01 0xff at 4 fl=
owid 1:1

Sending packets to fit those filters does not trigger a match. I'm a bi=
t confused why exact examples from the guide does not seem to work.

Any hints or experience on this would be much appreciated.


