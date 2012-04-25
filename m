From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Peak PCAN USB question
Date: Wed, 25 Apr 2012 07:37:48 +0000
Message-ID: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:57695 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392Ab2DYHyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Apr 2012 03:54:15 -0400
Received: from business-178-015-016-250.static.arcor-ip.net ([178.15.16.250] helo=remote.port.de)
	by mx.professional-internet.de with esmtp (Exim 4.69)
	(envelope-from <oe@port.de>)
	id 1SMwnU-0001o0-0u
	for linux-can@vger.kernel.org; Wed, 25 Apr 2012 09:37:56 +0200
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I'm working on a project where the application has to use can4linux and SocketCAN.
Mainly because can4linux has no USB support yet.
For some requests to the SocketCAN layer I use libsocketcan.
Can someone confirm that can_get_berr_counter(), can_get_state()
and may be some more functions are not working with the Peak PCAN USB Interface?

Regards
 Heinz
