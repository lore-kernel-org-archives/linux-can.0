From: du <duzhenhuan@gmail.com>
Subject: Re: socketcan receive queue too many frames
Date: Wed, 27 Mar 2013 12:01:25 +0000 (UTC)
Message-ID: <loom.20130327T125524-733@post.gmane.org>
References: <loom.20130327T122706-603@post.gmane.org> <5152DCF2.80804@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53096 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3C0MBy (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 Mar 2013 08:01:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UKp3T-0008E9-7R
	for linux-can@vger.kernel.org; Wed, 27 Mar 2013 13:02:11 +0100
Received: from 113.227.62.246 ([113.227.62.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 13:02:11 +0100
Received: from duzhenhuan by 113.227.62.246 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 13:02:11 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:


> What is "socketcan buffer"?
sorry ,I means socketcan only.
> 

> What kind of CAN frame do you get? Maybe error messages, due to the open
> bus?
It's not error message , just normal CAN  data frames.


I thought it may has something to do with buffer. 
If my application is not fast enough to read the frames in buffer,
 I can still get frames even the bus is open, is it right?



