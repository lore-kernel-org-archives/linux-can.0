From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 20:17:45 +0200
Message-ID: <523DE2C9.4020407@hartkopp.net>
References: <1881932.U1kQQJkqCz@heinz.site> <523DA147.7090403@pengutronix.de> <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com> <523DD2C3.7000505@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:61710 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3IUSRs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 14:17:48 -0400
In-Reply-To: <523DD2C3.7000505@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sebastian Haas <dev@sebastianhaas.info>, =?UTF-8?B?SGVpbnotSsO8cmdlbiA=?= =?UTF-8?B?T2VydGVs?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

On 21.09.2013 19:09, Marc Kleine-Budde wrote:
> On 09/21/2013 06:37 PM, Sebastian Haas wrote:
>> As Oliver already pointed out there are a bunch of applications outside
>> which may require a can4linux-like chardev API.
>>
>> But I also agree that merging an additional CAN framework makes not
>> much sense. I prefer to port can4linux drivers to SocketCAN for not
>> yet supported devices. But we may also think about an emulation of
>> chardev based APIs like can4linux to support legacy applications.
> 
> The emulation could probably be done in userspace. I'll ask our
> userspace graphics guys how they emulate legacy /dev/fbX on top of drm.
> 

Oh yes!

If there would be a solution to handle all this within a user-space driver
this would be my favorite solution too.

Btw. investing in a SocketCAN port is definitely a long-term solution for CAN
applications and should be the preferred way to go.

Regards,
Oliver


