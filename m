From: Wolfgang Wagner <wutz@unterderbruecke.de>
Subject: How to get the DA
Date: Thu, 16 Feb 2012 09:58:27 +0000 (UTC)
Message-ID: <loom.20120216T104829-444@post.gmane.org>
References: <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org> <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org> <loom.20120113T122554-557@post.gmane.org> <loom.20120116T103812-141@post.gmane.org> <20120116133140.GA26427@e-circ.dyndns.org> <loom.20120116T153805-349@post.gmane.org> <20120116153644.GA7763@e-circ.dyndns.org> <loom.20120207T160415-497@post.gmane.org> <20120208084602.GA412@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50191 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2BPJ6i (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 16 Feb 2012 04:58:38 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rxy6n-0000Db-0f
	for linux-can@vger.kernel.org; Thu, 16 Feb 2012 10:58:37 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2012 10:58:36 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2012 10:58:36 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

is there a simple way to get the destination address out of the ID, or has it to
be done with the struct cmsghdr, like implement in the jspy?

Greetings,
Wolfgang

