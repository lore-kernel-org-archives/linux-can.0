From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Wed, 28 Dec 2011 10:49:39 +0000 (UTC)
Message-ID: <loom.20111228T114009-686@post.gmane.org>
References: <20111220110059.GA311@e-circ.dyndns.org> <loom.20111220T150849-247@post.gmane.org> <20111220150545.GC311@e-circ.dyndns.org> <loom.20111220T160841-487@post.gmane.org> <20111220163247.GE311@e-circ.dyndns.org> <loom.20111221T111539-419@post.gmane.org> <20111221134302.GA12050@e-circ.dyndns.org> <loom.20111221T153828-216@post.gmane.org> <20111221155314.GC12050@e-circ.dyndns.org> <loom.20111222T115004-22@post.gmane.org> <20111223110445.GB12091@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51953 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab1L1Ktx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 28 Dec 2011 05:49:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rfr4x-0006JB-KK
	for linux-can@vger.kernel.org; Wed, 28 Dec 2011 11:49:52 +0100
Received: from p549CCB11.dip.t-dialin.net ([84.156.203.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Dec 2011 11:49:51 +0100
Received: from wutz by p549CCB11.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Dec 2011 11:49:51 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

am I right, if I start for every pgn I want to bridge a new process? Or will it
work if all pgns to be bridged are in one process? I'm just wondering what will
bring a better performance? 

--Wolfgang

