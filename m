From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v6 2/4] can: m_can: Rename m_can_priv to m_can_classdev
Date: Mon, 4 Mar 2019 12:14:19 -0600
Message-ID: <85e03abc-82ce-6fa9-f1bd-1a068fabba53@ti.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <20190301185043.9037-2-dmurphy@ti.com>
 <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Wolfgang

On 3/4/19 11:31 AM, Wolfgang Grandegger wrote:
> Hello,
> 
> there are still "LTL" after renaming m_can_priv to m_can_classdev.
> 

Yes I know but some of those become unreadable if I break them apart.

But if you want me to break them I can do it.

For instance
	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;

will become

	struct m_can_plat_priv *priv =
				(struct m_can_plat_priv *)m_can_class->device_data;

> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>> Rename the common m_can_priv class structure to
>> m_can_classdev as this is more descriptive.
> 
> If you change the struct name, I think you should also change the
> variable name to something more meaning full e.g.:
> 
>   struct m_can_classdev *cdev
> 
> instead of
> 
>   struct m_can_classdev *priv
> 
> 

Ack.  This change will grow this patch as s/priv/cdev is used 250x

Dan

> ... snip ...
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
