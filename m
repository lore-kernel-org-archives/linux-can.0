From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: candump -x: brs esi is set on non-canfd interfaces
Date: Tue, 22 Jan 2013 08:55:18 +0100
Message-ID: <2839107.LG5rdvYUWD@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39060 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab3AVHzY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 02:55:24 -0500
Received: from comm.systec-electronic.de (178-24-127-48-dynip.superkabel.de [178.24.127.48])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 9421F27A602
	for <linux-can@vger.kernel.org>; Tue, 22 Jan 2013 08:50:01 +0100 (CET)
Received: from ws-stein.localnet (unknown [192.168.10.63])
	by comm.systec-electronic.de (Postfix) with ESMTP id 9AA8097C275
	for <linux-can@vger.kernel.org>; Tue, 22 Jan 2013 08:55:22 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

a student noticed that during his CANopen SDO transfer traffic candump sometimes shows e.g.
> (000.000124)  can0  TX B E  641   [8]  00 32 33 34 35 36 37 38
while on a non-canfd interfaces. It seem to occur at some time and disappears again for one SDO transfer and it occurs for another transfer and stays forever. I see that candump always uses struct canfd_frame, but AFAICS the flags member should not be set at all, as alloc_can_skb does a memset on struct can_frame. So the padding bytes in can_frame are zero which are used for flags in canfd_frame.
When printing flags directly it is set to 0x7F. Has anybody an idea what could cause this? I could find any position which would manipulate the flags byte.

Best regards,
Alexander

