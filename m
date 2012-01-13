From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: bridging with can-gw
Date: Fri, 13 Jan 2012 11:31:48 +0000 (UTC)
Message-ID: <loom.20120113T122554-557@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org> <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48667 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757859Ab2AMLcC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 13 Jan 2012 06:32:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RlfMX-0005VP-0k
	for linux-can@vger.kernel.org; Fri, 13 Jan 2012 12:32:01 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2012 12:32:00 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2012 12:32:00 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> > Do you only bridge single frames?
> 
> The idea has crossed my mind also that when only single frames are bridged,
> a raw cangw may suit the need.
> A cangw setup _may_ not suit when transport protocol comes in place...

Thanks for your ideas.
cangw sounds really interesting but the point is my gw should be capable for 
transport protocol as well.

Thank you so far,
Wolfgang




