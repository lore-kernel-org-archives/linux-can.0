From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can-utils and mininet :
Date: Sat, 25 Mar 2017 16:03:54 +0100
Message-ID: <58e9975e-bd02-7818-15ff-0b1fb4d4efd4@hartkopp.net>
References: <BL2PR09MB110732E7774B7DDAFA9DC5AEE13E0@BL2PR09MB1107.namprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:16341 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdCYPHM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 11:07:12 -0400
In-Reply-To: <BL2PR09MB110732E7774B7DDAFA9DC5AEE13E0@BL2PR09MB1107.namprd09.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Halba, Khalid (IntlAssoc)" <khalid.halba@nist.gov>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "Mahmoudi, Charif (IntlAssoc)" <charif.mahmoudi@nist.gov>, Mario Kicherer <dev@kicherer.org>

Hi Khalid,

On 03/24/2017 10:31 PM, Halba, Khalid (IntlAssoc) wrote:
> I am trying to use can-utils inside mininet but I get an error whenever I try to run a can-utils application.
>
> I did the following :
>
> 1- Creating 2 hosts and 1 switch in mininet :
>
> sudo mn  --switch ovsk --mac --topo single,2

(..)

> Did anyone tried to run canutils and he was successful ?

I just had to 'google' for myself to learn about 'mininet':

https://sreeninet.wordpress.com/2014/11/30/mininet-internals-and-network-namespaces/

"1 of the key concepts used in Mininet is Network namespaces which is 
also the basis for Linux containers."

The CAN subsystem  of the Linux kernel is currently not namespace aware.

Mario Kicherer posted a patch to implement namespaces in parts of the 
CAN networklayer:

http://marc.info/?l=linux-can&m=148767639224547&w=2

So additionally to Mario's patch the virtual CAN driver has to be made 
namespace aware to make initial tests with mininet.

Are you interested to work on this stuff?

Regards,
Oliver
