From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: getting the fill level of rx and tx fifos
Date: Tue, 29 Nov 2011 12:25:46 +0100
Message-ID: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2C105@SBSPORT.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:56856 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751925Ab1K2LZu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 Nov 2011 06:25:50 -0500
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,
reading can.txt and list emails I could not  manage to get this informa=
tion.
Can please someone explain if and how it is possible to get this inform=
ation.
I need to know how many frames are still in the net layer and not yet h=
andled by the application.
And as well importand, how many not yet sent CAN Frames are in the sock=
et layer or the driver.=20

--
Mit freundlichen Gr=FC=DFen / With best regards

Heinz=20

PS:
I saw in candump.c getsockopt(fd, SO_SOCKET, SO_RCVBUF, &rcvbuf_size,..=
=2E.)
Is used.
But what does the result mean?
I get large numbers here : 124928


