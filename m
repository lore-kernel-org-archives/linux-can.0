From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can-utils and mininet :
Date: Sat, 25 Mar 2017 18:57:56 +0100
Message-ID: <075e2df7-ffff-591c-13d2-b7903d4e8777@hartkopp.net>
References: <BL2PR09MB110732E7774B7DDAFA9DC5AEE13E0@BL2PR09MB1107.namprd09.prod.outlook.com>
 <58e9975e-bd02-7818-15ff-0b1fb4d4efd4@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:33646 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdCYSAP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 14:00:15 -0400
In-Reply-To: <58e9975e-bd02-7818-15ff-0b1fb4d4efd4@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Halba, Khalid (IntlAssoc)" <khalid.halba@nist.gov>, Mario Kicherer <dev@kicherer.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Mahmoudi, Charif (IntlAssoc)" <charif.mahmoudi@nist.gov>

Answering myself ...

On 03/25/2017 04:03 PM, Oliver Hartkopp wrote:

> Mario Kicherer posted a patch to implement namespaces in parts of the
> CAN networklayer:
>
> http://marc.info/?l=linux-can&m=148767639224547&w=2
>
> So additionally to Mario's patch the virtual CAN driver has to be made
> namespace aware to make initial tests with mininet.

I applied Mario's patch for a test.

Then I followed

http://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/

and moved my already existing vcan0 virtual CAN interface to the 
namespace 'blue':

# ip netns add blue
# ip link set dev vcan0 netns blue

 From now vcan0 is not visible from 'ip link show' anymore.

But it is visible in the namespace 'blue':

# ip netns exec blue ip link list
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
6: vcan0: <NOARP> mtu 72 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/can

# ip netns exec blue cangen vcan0
write: Network is down

Obviously the move to the namespace puts the interface 'down', so ...
# ip netns exec blue ifconfig vcan0 up

And then executed
# ip netns exec blue cangen vcan0

And in another terminal
# ip netns exec blue candump any

Which shows the traffic on vcan0 in namespace blue - cool! Tnx Mario!

As vcan does not create two connected peers as veth I would suggest to 
use can-gw to connect (and modify/filter) CAN traffic between CAN 
interfaces inside/outside of namespaces.

Regards,
Oliver






