From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can-utils and mininet :
Date: Thu, 27 Apr 2017 18:01:55 +0200
Message-ID: <49758cf7-30a0-2681-be7f-57300f216c36@hartkopp.net>
References: <BL2PR09MB110732E7774B7DDAFA9DC5AEE13E0@BL2PR09MB1107.namprd09.prod.outlook.com>
 <58e9975e-bd02-7818-15ff-0b1fb4d4efd4@hartkopp.net>
 <075e2df7-ffff-591c-13d2-b7903d4e8777@hartkopp.net>
 <BL2PR09MB1107FA0FD632A060BE330B4AE1100@BL2PR09MB1107.namprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:34265 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755459AbdD0QCM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Apr 2017 12:02:12 -0400
In-Reply-To: <BL2PR09MB1107FA0FD632A060BE330B4AE1100@BL2PR09MB1107.namprd09.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Halba, Khalid (IntlAssoc)" <khalid.halba@nist.gov>
Cc: Mario Kicherer <dev@kicherer.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Mahmoudi, Charif (IntlAssoc)" <charif.mahmoudi@nist.gov>

Hi Khalid,

On 04/27/2017 05:26 PM, Halba, Khalid (IntlAssoc) wrote:

> It took me some time to understand namespaces and linux kernel patching .
> I just applied Mario's patch as well and it works as expected !.
> I can run can-utils on a different namespace now. Thanks.
> The kernel files I used are the ones in this directory :
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/mkl/linux-can/+/master/net/can/

The namespace support has now been completed and is available in Dave 
Miller's net-next tree for Linux 4.12 upstream:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

This reository contains this latest patch set for the CAN subsystem:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log?id=5e64ebc1c242523b491b5b5e5eba59243bb970cb

So using the net-next tree is the best choice for testing now.

> However , Mininet now fails to start. The error I get when I try to run the default topology is the following :
>
> //*** Adding links:
> //--------------------------------------------------------------------------------
> //Caught exception. Cleaning up...
> //Exception: Error creating interface pair (h1-eth0,s1-eth1): RTNETLINK answers: Operation not supported
>
> That's what I am currently troubleshooting.

Ah. You can not use veth to create the interface pair :-)
Ethernet interfaces do not work for CAN.

And for that reason ... tada! ... we have vxcan now!

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=a8f820a380a2a06fc4fe1a54159067958f800929

See the Kconfig change in this commit which is in net-next too.

Unfortunately you have to patch the 'ip' tool from the iproute2 package 
to be able to create vxcan pairs.

So you need to download

https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git

and then apply this patch:

http://marc.info/?l=linux-can&m=149311080629207&w=2

Finally you can create e.g. this pair
# ./ip link add rootcan type vxcan peer name bluecan
# ./ip link set dev bluecan netns blue

And then you have a CAN tunnel interface pair with the rootcan interface 
in the initial namespace and the bluecan interface in the 'blue' namespace.

Regards,
Oliver

> -----Original Message-----
> From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Oliver Hartkopp
> Sent: Saturday, March 25, 2017 1:58 PM
> To: Halba, Khalid (IntlAssoc) <khalid.halba@nist.gov>; Mario Kicherer <dev@kicherer.org>
> Cc: linux-can@vger.kernel.org; Mahmoudi, Charif (IntlAssoc) <charif.mahmoudi@nist.gov>
> Subject: Re: Can-utils and mininet :
>
> Answering myself ...
>
> On 03/25/2017 04:03 PM, Oliver Hartkopp wrote:
>
>> Mario Kicherer posted a patch to implement namespaces in parts of the
>> CAN networklayer:
>>
>> http://marc.info/?l=linux-can&m=148767639224547&w=2
>>
>> So additionally to Mario's patch the virtual CAN driver has to be made
>> namespace aware to make initial tests with mininet.
>
> I applied Mario's patch for a test.
>
> Then I followed
>
> http://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/
>
> and moved my already existing vcan0 virtual CAN interface to the namespace 'blue':
>
> # ip netns add blue
> # ip link set dev vcan0 netns blue
>
>  From now vcan0 is not visible from 'ip link show' anymore.
>
> But it is visible in the namespace 'blue':
>
> # ip netns exec blue ip link list
> 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 6: vcan0: <NOARP> mtu 72 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>      link/can
>
> # ip netns exec blue cangen vcan0
> write: Network is down
>
> Obviously the move to the namespace puts the interface 'down', so ...
> # ip netns exec blue ifconfig vcan0 up
>
> And then executed
> # ip netns exec blue cangen vcan0
>
> And in another terminal
> # ip netns exec blue candump any
>
> Which shows the traffic on vcan0 in namespace blue - cool! Tnx Mario!
>
> As vcan does not create two connected peers as veth I would suggest to use can-gw to connect (and modify/filter) CAN traffic between CAN interfaces inside/outside of namespaces.
>
> Regards,
> Oliver
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
