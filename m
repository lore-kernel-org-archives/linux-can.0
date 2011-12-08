From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: iproute2-j1939
Date: Thu, 8 Dec 2011 16:44:10 +0000 (UTC)
Message-ID: <loom.20111208T171058-366@post.gmane.org>
References: <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57496 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab1LHQoZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Dec 2011 11:44:25 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYh56-0003Tf-8X
	for linux-can@vger.kernel.org; Thu, 08 Dec 2011 17:44:24 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 17:44:24 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2011 17:44:24 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

OK, I should read all posts not only the last one.

I made:
with the new one

$iproute2-j1939> make CC=powerpc-603e-linux-gnu-gcc

same error "AF-CAN" undeclared



$can-j1939-modules>make KERNEL_DIR=<...> C=powerpc-603e-linux\
-gnu-gcc

make[1]: *** No rule to make target `modules'.  Stop.
make: *** [modules] Error 2

So do you think I have to replace the can.h in the
kernel_header_path
(/,.../sysroot-target/kernel-headers/include/linux)?

--Wolfgang


