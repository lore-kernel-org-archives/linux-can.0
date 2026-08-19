Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135041DE0E;
	Wed, 19 Aug 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127405; cv=none; b=QTSGg4T6vGo+P4W5enWu6Ik9fpZIvC8bK/ooC+z49xkPIbTWemQFu2TH6uyTOA2R782LZ9TJYvNEWqS9rnDO308IW803Gpd8hnkUi2nMFQ8xfimO0oCRz5HhygeiFI/PI9GcCTFkk8EeNBaU2fo9nn5v6lojkInnpBR8p29JicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127405; c=relaxed/simple;
	bh=wOggxaKqRmlsH3XN2wQiBOBb7pINN5M+Q17Nb0aScMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rny4mhakzFm0jLpi2gNdHBhsV5Lyx9rIyNoEWg+BGr21osP8ulTe3Ya10dnt8ZL5ptTchngw0bieB2VMCbj/4d9mndA5Fz88H9y4tdO5pCMm/3O8VWjpqmZCD5ADXkrGQmyygiQGtdZyops4CLjZg3KcswsU/aNPvLCmFbYD1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 1FBB210464D;
	Wed, 19 Aug 2026 08:16:31 +0000 (UTC)
Message-ID: <95f34c69-39b2-4e0a-83ce-ba7fdf5b7211@enpas.org>
Date: Wed, 19 Aug 2026 17:16:29 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: Fix stack out-of-bounds write in
 can327_handle_prompt()
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>, Baul Lee <baul.lee@xbow.com>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
References: <20260819054201.67294-1-baul.lee@xbow.com>
 <20260819-unbiased-impossible-foxhound-c525da-mkl@pengutronix.de>
From: Max Staudt <max@enpas.org>
In-Reply-To: <20260819-unbiased-impossible-foxhound-c525da-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 3:23 PM, Marc Kleine-Budde wrote:
> On 19.08.2026 14:42:01, Baul Lee wrote:
>> can327_handle_prompt() hexdumps the frame queued for transmission, two
>> hex characters per payload byte, into an 18-byte on-stack buffer sized
>> for a classical 8-byte payload. The loop runs frame->len times without a
>> clamp, and frame is a struct can_frame copied verbatim from the skb
>> passed to can327_netdev_start_xmit().
>>
>> A CAN XL frame aliases struct can_frame such that canxl_frame.flags,
> 
> I've a patch pending, that drops CAN_XL frames on non CAN_XL interfaces:
> 
> https://lore.kernel.org/all/20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org/
> 
> So I think this patch is not needed.

Agreed, thanks!

Just in case you decide to take Baul's patch anyway, here is my

Reviewed-by: Max Staudt <max@enpas.org>

