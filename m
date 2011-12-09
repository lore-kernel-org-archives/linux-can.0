From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 10:56:01 +0000 (UTC)
Message-ID: <loom.20111209T114335-991@post.gmane.org>
References: <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org> <20111209080726.GA325@e-circ.dyndns.org> <loom.20111209T095640-685@post.gmane.org> <20111209094856.GC325@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60565 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab1LIK4P (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 05:56:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYy7h-0003g7-0r
	for linux-can@vger.kernel.org; Fri, 09 Dec 2011 11:56:13 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 11:56:13 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 11:56:13 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> You can safely add "#define AF_CAN 29" and "#define AF_CAN PF_CAN" in
"sys/socket.h"

Ok, I have, done that and it worked but now the next error occured, next thing
was not declared. So I thought, I will build the newer oselas toolchain? Does
this make sense?

new one:                       old one:
gcc-4.5.2                      gcc-4.3.2
glibc-2.13-binutils-2.21       glibc-2.8-binutils-2.18
linux-2.6.36                   linux-2.6.27


--Wolfgang

