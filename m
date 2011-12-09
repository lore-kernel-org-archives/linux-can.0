From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 07:28:20 +0000 (UTC)
Message-ID: <loom.20111209T082142-596@post.gmane.org>
References: <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org> <4EE1B0DE.3040607@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47520 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab1LIH2i (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 02:28:38 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYusm-0002KH-P2
	for linux-can@vger.kernel.org; Fri, 09 Dec 2011 08:28:36 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 08:28:36 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 08:28:36 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Morning,

> What do you use for KERNEL_DIR=<..> ??
> Can you send the complete line?
> 
I have build the BSP (which is supporting socketcan) some time ago;

I make in ip2route-j1939:

$ make KERNEL_DIR=</home/wolfgang/phytec/kernel/OSELAS.BSP-Phytec-\
phyCORE-MPC512x-tiny-PD09.1.0/platform-phyCORE-MPC5121e/build-target\
/linux-2.6.31> CC=powerpc-603e-linux-gnu-gcc

