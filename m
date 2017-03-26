From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can-utils and mininet :
Date: Sun, 26 Mar 2017 19:35:55 +0200
Message-ID: <b391ad35-32bb-bdae-4e09-bfea63ddbb26@hartkopp.net>
References: <BL2PR09MB110732E7774B7DDAFA9DC5AEE13E0@BL2PR09MB1107.namprd09.prod.outlook.com>
 <58e9975e-bd02-7818-15ff-0b1fb4d4efd4@hartkopp.net>
 <0e9550b8-6fcb-fbbe-f72f-55a97e8a4a99@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:24856 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdCZRhK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Mar 2017 13:37:10 -0400
In-Reply-To: <0e9550b8-6fcb-fbbe-f72f-55a97e8a4a99@kicherer.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Kicherer <dev@kicherer.org>
Cc: "Halba, Khalid (IntlAssoc)" <khalid.halba@nist.gov>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Mahmoudi, Charif (IntlAssoc)" <charif.mahmoudi@nist.gov>

Hi Mario,

On 03/26/2017 12:56 PM, Mario Kicherer wrote:
> I am interested in virtual CAN interface pairs and I would develop a
> patch.

IMHO I doesn't make sense to create vcan interface pairs as done by the 
veth driver in linux/drivers/net/veth.c.

E.g. we can move real CAN interfaces to namespaces too, which could make 
sense on some setups:
# ip link set dev can0 netns blue

That's why I wonder whether we could just use can-gw with an extended 
cangw tool. Are you aware of cangw and its functionality??
(see help text with 'cangw -?')

My suggestion would be to extend can-gw in a way that you can provide 
the namespace name to CAN interfaces, when (and only when) cangw is used 
from default/global namespace.

When cangw is executed inside a namespace it can only access the CAN 
interfaces belonging to that namespace.

So inside the default/global namespace we could connect CAN interfaces 
like this:

# cangw -A -s can0 -d vcan0@blue -e
# cangw -A -s vcan0@blue -d can0 -e

The good thing with cangw would be the possibility to filter for 
(multiple) CAN IDs and/or to be able to modify the routed CAN frames, 
e.g. to alter CAN Identifiers with binary operations.

> But first, I would like to know if my initial patch will be
> accepted. Unfortunately, I did not receive any feedback so far.

I hoped someone else would also try your patch :-)

IMO the patch goes into the right direction and it fits for the initial 
step. Of course CAN_BCM and CAN_GW would need to be supported too (see 
above).

Best regards,
Oliver

