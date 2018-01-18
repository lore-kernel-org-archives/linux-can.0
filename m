From: =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>
Subject: Re: j1939 ACL
Date: Thu, 18 Jan 2018 13:01:51 +0100
Message-ID: <a27d8272-a796-2261-449e-1407158566c3@smile.fr>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from idris.smile.fr ([91.216.209.19]:52085 "EHLO idris.smile.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbeARMBx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Jan 2018 07:01:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by idris.smile.fr (Postfix) with ESMTP id 2356C1EE174B
        for <linux-can@vger.kernel.org>; Thu, 18 Jan 2018 13:01:52 +0100 (CET)
Received: from idris.smile.fr ([127.0.0.1])
        by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nXnUcDREvcwa for <linux-can@vger.kernel.org>;
        Thu, 18 Jan 2018 13:01:52 +0100 (CET)
Received: from [192.168.0.48] (lep60-1-78-225-8-236.fbx.proxad.net [78.225.8.236])
        by idris.smile.fr (Postfix) with ESMTPSA id E9B241EE16E1
        for <linux-can@vger.kernel.org>; Thu, 18 Jan 2018 13:01:51 +0100 (CET)
In-Reply-To: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Hi all,
Hi Oleksij,
> what is the proper or expected way for j1939 ACL (address claiming)?
>
> Should it be done by automatically by kernel? Are there any existing
> examples?
The address claiming is not under the responsibility of the kernel but 
under responsibility of user space.
You should have a look and play with the jacd daemon that implements the 
Address Claiming procedure for you (see [1]).
> Is this a correct ACL message?
> source address: for example 0x80
> PGN: 0xee00
> DATA: NAME
Yes that is correct but do not forget to set the destination adresse to 
"everybody" (0xFF)

Here is an example of Address Claim sequence where device 
AAAAAAAAAAAAAAAA enters the network and device BBBBBBBBBBBBBBBB already 
have address 0xAA:

(1516110467.317706) can0 18EAFFFE#00EE00 ------------> Device 
AAAAAAAAAAAAAAAA asks for addresses of all other devices on the network
(1516110467.329943) can0 18EEFFAA#BBBBBBBBBBBBBBBB --> Device 
BBBBBBBBBBBBBBBB says it has address 0xAA
(1516110468.568107) can0 18EEFFAA#AAAAAAAAAAAAAAAA --> Device 
AAAAAAAAAAAAAAAA claims address 0xAA. That is allowed because his device 
name has an higher priority.
(1516110468.576132) can0 18EEFFAB#BBBBBBBBBBBBBBBB --> Device 
BBBBBBBBBBBBBBBB claims another address.

Regards

Rémy

[1] https://github.com/kurt-vd/can-utils/blob/j1939-v6/jacd.c

