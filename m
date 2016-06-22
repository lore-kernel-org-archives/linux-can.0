From: ajneu <ajneu1@gmail.com>
Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer space available)
Date: Wed, 22 Jun 2016 15:00:48 +0000 (UTC)
Message-ID: <loom.20160622T165844-987@post.gmane.org>
References: <loom.20160622T163626-806@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46335 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbcFVPSE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jun 2016 11:18:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFjeA-0007z5-KH
	for linux-can@vger.kernel.org; Wed, 22 Jun 2016 17:00:54 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 17:00:54 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 17:00:54 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

>    errno 105 (No buffer space available)
This is ENOBUFS

ajneu <ajneu1 <at> gmail.com> writes:


> * My config:
>   sudo ip link set can0 down
>   sudo ip link set can0 txqueuelen 10
>   sudo ip link set can0 up type can bitrate 250000
> 
> 1st program run:
> ~> block on 33'rd write (32 frames queued)
> 
> 2nd program run:
> ~> block on 7'th write (6 frames queued)
> 
> 3rd program run:
> ~> block on 7'th write (6 frames queued)
> 
> 4rd program run:
> ~> when trying 3'rd write: errno 105 (No buffer space available)
>    (so 2 frames queued)
> 
> PLEASE: could sombody explain these numbers !
> They don't make sense to me.

Above if you sum the queued frames, I get: 32+6+6+2 = 46 queued


I've checked it for other values of txqueuelen:

sudo ip link set can0 down
sudo ip link set can0 txqueuelen 1
sudo ip link set can0 up type can bitrate 250000
~> queued: 32+5 == 37

sudo ip link set can0 down
sudo ip link set can0 txqueuelen 2
sudo ip link set can0 up type can bitrate 250000
~> queued: 32+6 == 38

sudo ip link set can0 down
sudo ip link set can0 txqueuelen 10
sudo ip link set can0 up type can bitrate 250000
~> queued: 32+6+6+2 == 46

sudo ip link set can0 down
sudo ip link set can0 txqueuelen 46
sudo ip link set can0 up type can bitrate 250000
~> queued: 32+6+6+6+6+6+6+6+6+2 == 82



So this is the general formula:

For txqueuelen == N, i.e.

sudo ip link set can0 down
sudo ip link set can0 txqueuelen N
sudo ip link set can0 up type can bitrate 250000
~> queued: N + 36


Please can someone explain this...
(And also how I can get guaranteed blocking behaviour. ;)  )

Thanks.
ajneu

