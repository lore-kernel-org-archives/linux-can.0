Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0B33F5BE;
	Sat, 26 Sep 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436423; cv=none; b=WnqLtj/JL/U8jqGSFQm3MIqnVKDx1ZZ30tYcF1pVRi5HskAtz5sAzNiTy4ORRKA/v+NLVwJYsBZElOLD+o2k8wdaU7pPWe4PLyFN9zKxhpFDp4Gqi0wVqUKnNuOlgjtspP1zTqWqDxGw8bEc3GmKmhZ5B8RY+UmFIbNXWcRMeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436423; c=relaxed/simple;
	bh=z3rqi5lnhp3ytAxTUH3SdZvOqMvHh55hc83Yuk+tdHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcZYHbH6/FG1p4yplXOYZAhuaJKmBwStgO7L4GD/+y4s8j665OkezjT1TZQbIq/Jqz1VgRHrAG35GUN5Nm7g99Vs9A3TnjQXR9AT3f8ZGtv3Oubrn+aogBeQXjQ2mFBz7guU+/9uC+vCXmyvaBoFMzOLUv3iy49zrY4iyaFL2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 3AD17104F78;
	Sat, 26 Sep 2026 15:26:51 +0000 (UTC)
Message-ID: <0daea1b3-82ef-48f0-8d35-6ce0100b60bf@enpas.org>
Date: Sun, 27 Sep 2026 00:26:49 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] can: rx-offload: add a per-IRQ receive context
Content-Language: en-US
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>, Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
 <20260925144558.2909639-3-ciprianmarian.costea@oss.nxp.com>
From: Max Staudt <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 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
 1Nk4wgjdif6n69chAwuDQyOfWdz/dQ==
In-Reply-To: <20260925144558.2909639-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your patch. The general idea sounds useful, and at a quick 
glance, the implementation seems sound. I'm not able to do a full review 
- please wait for a maintainer's reply.

Comments below, from the point of view of a simple CAN driver's 
maintainer (can327).



On 9/25/26 11:45 PM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> The IRQ handler fills skb_irq_queue without a lock and the finish helpers
> then splice it into skb_queue under skb_queue.lock. This breaks when a
> driver uses the helpers from more than one IRQ line. On NXP S32G2, the
> flexcan handlers can run at the same time on different CPUs and corrupt
> skb_irq_queue.

Please add "Currently, " to the beginning of this paragraph.


> Add struct can_rx_offload_irq, one per IRQ line, which holds
> skb_irq_queue, skb_queue_len_max and the mailbox range. skb_queue and napi
> stay in struct can_rx_offload and are shared by all contexts.

The IRQ naming gives me a bit of a headache. It may be IRQ in the case 
of flexcan, but can be something else in other drivers. Also, _irq gives 
the impression that the struct stores an IRQ, or at least something 
related to it, but this really does not.

Can you please rename the new struct and concept to something else? 
Maybe _queue? And then the old struct can be renamed to _common or 
_shared or something. The maintainers may have better naming ideas.

I think you can keep the name skb_irq_queue inside the struct, my 
request is about the new struct's name itself. In the same vein, 
expanding the new struct's explanatory comment would help - please 
explain that *the purpose* of having this struct is so you can have one 
per source, *such as* one for each unique IRQ that the same CAN hardware 
may trigger.


> @@ -351,64 +378,88 @@ EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
>   
>   static int can_rx_offload_init_queue(struct net_device *dev,
>   				     struct can_rx_offload *offload,
> +				     struct can_rx_offload_irq *offload_irq,
>   				     unsigned int weight)
>   {
> -	offload->dev = dev;
> -
> -	/* Limit queue len to 4x the weight (rounded to next power of two) */
> -	offload->skb_queue_len_max = 2 << fls(weight);
> -	offload->skb_queue_len_max *= 4;
> -	skb_queue_head_init(&offload->skb_queue);
> -	__skb_queue_head_init(&offload->skb_irq_queue);
> +	struct can_rx_offload_irq *pos;
> +	u32 skb_queue_len_max;
> +
> +	offload_irq->offload = offload;
> +	__skb_queue_head_init(&offload_irq->skb_irq_queue);
> +
> +	/* The first registered IRQ initializes the shared state. */
> +	if (!offload->irq_cnt) {
> +		offload->dev = dev;
> +		skb_queue_head_init(&offload->skb_queue);
> +		INIT_LIST_HEAD(&offload->irqs);
> +		netif_napi_add_weight(dev, &offload->napi,
> +				      can_rx_offload_napi_poll, weight);
> +	} else if (weight > offload->napi.weight) {
> +		/* All contexts feed the same NAPI, keep the largest weight. */
> +		offload->napi.weight = weight;
> +	}
> +	list_add_tail(&offload_irq->node, &offload->irqs);
> +	offload->irq_cnt++;
>   
> -	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
> -			      weight);
> +	/* Limit queue len to 4x the weight (rounded to next power of two).
> +	 * All contexts feed the same skb_queue, so they share its limit.
> +	 */
> +	skb_queue_len_max = 2 << fls(offload->napi.weight);
> +	skb_queue_len_max *= 4;
> +	list_for_each_entry(pos, &offload->irqs, node)
> +		pos->skb_queue_len_max = skb_queue_len_max;
>   
>   	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
> -		__func__, offload->skb_queue_len_max);
> +		__func__, skb_queue_len_max);
>   
>   	return 0;
>   }

This API is confusing now. It's called _init_queue(), but you've really 
changed it into something that acts like _init_or_add_queue(). Please 
rename this, and while at it, please add an explanatory comment for the 
function above it, since it has grown quite complex.

The comment you added in can_rx_offload_del() is a positive example - 
having more of this stuff helps! Actually, that specific comment talks 
about "contexts" - please try to align that wording with whatever you 
rename the _irq struct to, such as "queue", to keep the code and 
comments consistent for the next reader.


Thanks,
Max

