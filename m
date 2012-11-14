From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 14 Nov 2012 21:40:24 +0000 (UTC)
Message-ID: <loom.20121114T223620-30@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52608 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933106Ab2KNVkk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Nov 2012 16:40:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TYkhS-0000m5-OE
	for linux-can@vger.kernel.org; Wed, 14 Nov 2012 22:40:47 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 22:40:46 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 22:40:46 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I should add that when this problem occurs, trying to transmit on the CAN 
interface returns the error "No buffer space available"

- Mike



