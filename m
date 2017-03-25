From: =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>
Subject: Re: [PATCH v3 5/6] can: m_can: Configuration for TX and TX event
 FIFOs
Date: Sat, 25 Mar 2017 17:29:21 +0100
Message-ID: <e7d73a46-6d53-71bf-9f93-ba07be83d547@gmx.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
 <1490374171-15190-5-git-send-email-mario.huettel@de.bosch.com>
 <b46cde32-2e06-2685-1a90-9d8a48d9dd5e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:64052 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbdCYQ3a (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 25 Mar 2017 12:29:30 -0400
In-Reply-To: <b46cde32-2e06-2685-1a90-9d8a48d9dd5e@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org


On 03/25/2017 05:16 PM, Oliver Hartkopp wrote:
>
>
> On 03/24/2017 05:49 PM, Mario Huettel wrote:
>>
>> -    /* only support one Tx Buffer currently */
>> -    m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
>> -            priv->mcfg[MRAM_TXB].off);
>> +    if (priv->version == 30) {
>> +        /* only support one Tx Buffer currently */
>> +        m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
>> +                priv->mcfg[MRAM_TXB].off);
>> +    } else {
>> +        /* TX FIFO is used for newer IP Core versions */
>> +        m_can_write(priv, M_CAN_TXBC,
>> +                (priv->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |
>
> Are you sure?
>
> Shouldn't this be TXBC_NDTB_SHIFT too?
>

No, the code is correct.
* NDTB (Number of Dedicated Transmit Buffers) is used for 1 Buffer
configuration.
* TFQS (Transmit FIFO/QUEUE Size) is used to set HW-FIFO size.

The driver uses either a dedicated buffer for v3.0.x or the FIFO for
versions >= v3.1.x

Mario
