From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils 3/3] slcand: remove program as it is undistributable
Date: Sun, 12 Jan 2014 20:59:19 +0100
Message-ID: <52D2F417.9090807@hartkopp.net>
References: <20130817190521.GK30496@pengutronix.de> <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389481823-8379-4-git-send-email-u.kleine-koenig@pengutronix.de> <CAGm1_ksVCPftbN_9BzS6tJ+-WWmfckegSQ9h_8USnNdKKfW01w@mail.gmail.com> <52D27518.5040202@hartkopp.net> <CAGm1_kuooN2PUQGAEqhG=59qJWT-10F0yvAQWVgnS9jDXnB05Q@mail.gmail.com> <52D2DD7B.2070003@hartkopp.net> <CAGm1_ktO3VxEG++Sq8s2dDJO3zZFr8O58QMs9oazr0N5zPvMyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:50239 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaALT7W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 14:59:22 -0500
In-Reply-To: <CAGm1_ktO3VxEG++Sq8s2dDJO3zZFr8O58QMs9oazr0N5zPvMyg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>



On 12.01.2014 20:54, Yegor Yefremov wrote:

>>> Would this call do the job: http://man7.org/linux/man-pages/man3/daemon.3.html?
>>
>> Yes, I think so.
>>

(..)

> 
> Would it be sufficient to submit a patch, that reimplements
> daemonize() and fixes license? Instead of removing the file and
> readding it?
> 

Yes. Fixing this with a patch should be appropriate.

There's so many slcan specific code in slcand (of course) that pointing at
this special issue is the right thing to do IMO.

Regards,
Oliver
