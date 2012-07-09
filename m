From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 11:22:31 +0200
Message-ID: <4FFAA2D7.4010905@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com> <4FF8102C.8030609@grandegger.com> <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com> <4FF9E9E4.4090602@grandegger.com> <CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com> <4FFA85B3.5080800@grandegger.com> <CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com> <4FFA9466.3040600@grandegger.com> <CABMxt4jkBNzjWtpRn5YJHyEOGu-XN7ehTZOXCt3pxLr81aH_Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39567 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2GIJWe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 05:22:34 -0400
In-Reply-To: <CABMxt4jkBNzjWtpRn5YJHyEOGu-XN7ehTZOXCt3pxLr81aH_Bg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 07/09/2012 11:19 AM, Mohamed HAMZAOUI wrote:
> My real-time requirement is minimum to be accurate on 1ms for manage
> deterministic CAN protocol (like MILCAN).

Well, what jitter would be acceptable for a period of 1ms?

BTW: what happens if you use a period of 0.7 ms. Do you then see a
period of 1ms on the bus?

Wolfgang.

