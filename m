From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6 2/4] can: m_can: Rename m_can_priv to m_can_classdev
Date: Mon, 4 Mar 2019 19:26:00 +0100
Message-ID: <c49f915e-852c-fe4f-cf92-4b59d958e066@grandegger.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <20190301185043.9037-2-dmurphy@ti.com>
 <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
 <85e03abc-82ce-6fa9-f1bd-1a068fabba53@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85e03abc-82ce-6fa9-f1bd-1a068fabba53@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 04.03.19 um 19:14 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/4/19 11:31 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> there are still "LTL" after renaming m_can_priv to m_can_classdev.
>>
> 
> Yes I know but some of those become unreadable if I break them apart.
> 
> But if you want me to break them I can do it.
> 
> For instance
> 	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
> 
> will become
> 
> 	struct m_can_plat_priv *priv =
> 				(struct m_can_plat_priv *)m_can_class->device_data;

Perfect! See also my comment below.

> 
>> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>>> Rename the common m_can_priv class structure to
>>> m_can_classdev as this is more descriptive.
>>
>> If you change the struct name, I think you should also change the
>> variable name to something more meaning full e.g.:
>>
>>   struct m_can_classdev *cdev
>>
>> instead of
>>
>>   struct m_can_classdev *priv
>>
>>
> 
> Ack.  This change will grow this patch as s/priv/cdev is used 250x

That's the price for changing the name. As we have it in a separate
patch, it should be OK.

Ideally, also m_can_platform.c and tcan4x5x.c should then use that name
for "struct m_can_classdev".

Wolfgang.
