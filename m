From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 08 Mar 2013 13:04:40 +0100
Message-ID: <5139D3D8.2020305@volkswagen.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be> <5139A78D.9060005@pengutronix.de> <20130308100548.GA496@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:32821 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab3CHMFm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 07:05:42 -0500
In-Reply-To: <20130308100548.GA496@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Am 08.03.2013 11:05, schrieb Kurt Van Dijck:

>>> The J1939 API that is available on gitorious[1] is waiting for acceptance.
>>> The API has not changed for almost a year now, and is working.
>>> The J1939 API is quite different from raw CAN, since J1939 adds an
>>> addressing scheme. This makes it hard for non-J1939 users to
>>> judge about the usefullness of the API.

Yes. Unfortunately.

>>> Therefore, it's important that users of the J1939 stack share their
>>> opinion about it.
>>> Therefore, also your opinion matters and may contribute to the acceptance.
>>> If you find the J1939 stack usefull of course :-)

Indeed user feedback is really required.

>>
>> Would it be possible to add the j1939 support to staging? I mean from
>> the technical and from the political (is staging reserved for drivers
>> only?) point of view.
>
> That is a good idea.
> Technically, staging is underneath drivers/, which answers the political
> question: yes, it's for drivers probably.

Please check:

http://www.kroah.com/log/linux/linux-staging-update.html

It's for "drivers" and "filesystems".

You don't need to modify the kernel infrastructure to add drivers and
filesystems - but you need to change infrastructure to add new networking
functionalities.

Therefore i don't think, that this would work with the staging approach.

Btw. how can we gain more interest and users to the evaluation of Kurts j1939
stack? I remember about 3 persons asking about it (even about details) - what
happened to them?

Regards,
Oliver
