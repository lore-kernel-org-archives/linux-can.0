From: Steffen Rose <ro@emtas.de>
Subject: Re: [Socketcan-users] increase buffer size
Date: Tue, 24 Jan 2012 16:42 +0100
Message-ID: <3362435.B6CXOz5dhC@lisa>
References: <1567213.2GCzMlGyKY@lisa> <4F1E9DA9.9060804@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63105 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab2AXPmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2012 10:42:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 74326561BDC
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 16:42:04 +0100 (CET)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rConhW+CThzN for <linux-can@vger.kernel.org>;
	Tue, 24 Jan 2012 16:42:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id BA167561B3F
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 16:42:03 +0100 (CET)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	(Authenticated sender: ro@emtas.de)
	by kolab.emtas.de (Postfix) with ESMTPSA id 79F0B5615F2
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 16:42:03 +0100 (CET)
In-Reply-To: <4F1E9DA9.9060804@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello Oliver

Am Dienstag, 24. Januar 2012, 13:01:45 schrieb Oliver Hartkopp:
> ifconfig can0 txqueuelen 1000
> ip link set can0 txqueuelen 1000

You wrote, that this command do not change the socket quere, this comma=
nd=20
change the quere within the can adaptation. I hope, I understand this=20
correctly.

Is there a dependency to a specific SocketCAN version? Especially I'm=20
interested on embedded linux devices. Is the quere part of the common=20
socketcan code or is it depend of the implementation?

--=20
Mit freundlichen Gr=FC=DFen / Regards
Steffen Rose
www.emtas.de


