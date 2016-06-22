From: ajneu <ajneu1@gmail.com>
Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer space available)
Date: Wed, 22 Jun 2016 15:18:35 +0000 (UTC)
Message-ID: <loom.20160622T171459-416@post.gmane.org>
References: <loom.20160622T163626-806@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46681 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbcFVPTj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jun 2016 11:19:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFjvs-0003GC-RV
	for linux-can@vger.kernel.org; Wed, 22 Jun 2016 17:19:13 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 17:19:12 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 17:19:12 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

> My test-program blocks (in write) in the beginning (the 1st few
> program-runs), but then after a number of program-restarts I eventually get:
>    errno 105 (No buffer space available)
> which is not acceptable, since I want to block (in the write), and not get
> any error!!

One way that I can eliminate this problem (that I've discovered), is ...
if at the program-start I use libsocketcan to issue can_do_stop() followed
by can_do_start(). 

(Libsocketcan seems more and more important, the longer I think about it.)

