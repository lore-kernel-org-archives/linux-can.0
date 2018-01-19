From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: j1939 ACL
Date: Fri, 19 Jan 2018 12:14:09 +0100
Message-ID: <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeASLOL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jan 2018 06:14:11 -0500
In-Reply-To: <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org

Hi

thank you all!

after playing with jacd i have a bit more questions:
- do any one already using kernel j1939? any suggestions or request for
changes?
- is jacd used for productions systems? is it enough to have it in the
usersapce? timing issues?
- how address and naming are synced between applications?

On 18.01.2018 12:49, Rémy Dziemiaszko wrote:
> Le 18/01/2018 à 10:40, Oleksij Rempel a écrit :
>> Hi all,
> Hi Oleksij,
>> what is the proper or expected way for j1939 ACL (address claiming)?
>>
>> Should it be done by automatically by kernel? Are there any existing
>> examples?
> The address claiming is not under the responsibility of the kernel but
> under responsibility of user space.
> You should have a look and play with the jacd daemon that implements the
> Address Claiming procedure for you (see [1]).
>> Is this a correct ACL message?
>> source address: for example 0x80
>> PGN: 0xee00
>> DATA: NAME
> Yes that is correct but do not forget to set the destination adresse to
> "everybody" (0xFF)
> 
> Here is an example of Address Claim sequence where device
> AAAAAAAAAAAAAAAA enters the network and device BBBBBBBBBBBBBBBB already
> have address 0xAA:
> 
> (1516110467.317706) can0 18EAFFFE#00EE00 ------------> Device
> AAAAAAAAAAAAAAAA asks for addresses of all other devices on the network
> (1516110467.329943) can0 18EEFFAA#BBBBBBBBBBBBBBBB --> Device
> BBBBBBBBBBBBBBBB says it has address 0xAA
> (1516110468.568107) can0 18EEFFAA#AAAAAAAAAAAAAAAA --> Device
> AAAAAAAAAAAAAAAA claims address 0xAA. That is allowed because his device
> name has an higher priority.   
> (1516110468.576132) can0 18EEFFAB#BBBBBBBBBBBBBBBB --> Device
> BBBBBBBBBBBBBBBB claims another address.
> 
> Regards
> 
> Rémy
> 
> [1] https://github.com/kurt-vd/can-utils/blob/j1939-v6/jacd.c
> 
