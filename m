Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658271;
	b=4PJk3bO2ctafgAyzEGjJQujwVVZMk3gA2HcrC2cL6h1LqqXqBPa3ej0Q1fWUvY11p9qY
	 MdWoAz2aCdhQ11q4bTDEmBTYm1fmqB2DY9jdZ9qnuqtu84FN5fDaSxxmxL+Hh/Tp7Grsj
	 ex85Dta6GzLgOyPDkMAFEZJxQuYZXqEw/VmcEgIazKTvrxy3SpsX71X+fMFhdQ6bKC9xZ
	 b5tJE1CbmCQcvoPNbfFPMgq+K/VGEQCHll7VIe2RMOypgPyQ8bBZGCpp3z58l4CFMtAjr
	 mXZWyiPQGIdu21f/e6MvYU9cN1hD1cyUdQFV/+5try44gIGNB5n6ubeLmYvdYK6OEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
	b=SAKEgSN8HeWd6IpUzLUFvsDgqnvOrp5WIARxBqCQCfoDYoX1uNCj/jrYHjkGNvIQFR1R
	 vBQL8lZJ+5bJ87TzzRZAijrEzYOnoZEWSBc7O3uif0g+rRt2WLP+4mKQbC/MAq5P5gMI4
	 mrAVvAp4houVlJSnjbIkvyARTh5xlijPq0h5g/QKT2TsYVwZqj2czsYSfD/UULD7vNWEm
	 E4FuiWzdbzsTH+lyc5+Wc4qVMJK7v4ZZMSzFTEL+1XnuIHFj2E+kbrVR94zNQ85RRH4WW
	 /gf39q5sp/bvGuH5qA40UhpcGcMqVXbQGoNChIWSHRMxyujE3oOpkkvEwcgYNbIyRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="A/Mmwau1";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ej0LLEa1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F1606A31D
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 08:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/Mmwau1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ej0LLEa1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792658265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
	b=A/Mmwau1ifS5fM8g5xYGJ4DNLg+F8zsFs6054zqh/xOgAkmVA/g22xMWYUrK6iKzHckxA/
	T/AsmdjYQTjIQpFxONdR1htTfP/wIY8WbHlCGzmEs0kFTPXuzEH0tmTN6By/tfytfv7ZqZ
	rPOOnuszDmDOOVY/umi+x4Ow/2d6I3E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-8GptimyqMWye6xy1lLYo1w-1; Thu, 22 Oct 2026 08:37:44 +0000
X-MC-Unique: 8GptimyqMWye6xy1lLYo1w-1
X-Mimecast-MFC-AGG-ID: 8GptimyqMWye6xy1lLYo1w_1792658263
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so9538225e9.0
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792658263; x=1793263063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
        b=ej0LLEa1COd0miBtYfh/Re7eVCX43R1PVUXERJQsuuzdKKJq/B1lf1gSgoGiaw+ADB
         8ROJZyF++ZY0Ksx+LsYy4gmPWE9UFt4r/6/4RpjEqMv9tut4Bn+oM+0n3zdwFTeTX1Md
         XG2NGzh+5odOVOu8sWSglmAWUHtw67EoV2lX+c3EopAfsr9C41UNfboXSF2ZOaYHmn9U
         1+7GpTyRJMZS4FOFpzPgnib8mHMiFKb+GC76V9bD5rYO9JpulVxcVoYVWlfqQCO7Afwc
         76KJoft4PY4fb75dixUVQv8McMHZ/1GxpIbZFxMG+KJMNvyoAgF93GGLy//zN900VA5e
         01dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658263; x=1793263063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOooTUff7X5TAnLovj39ayLbqx8ey/Hg8MJZZ+hSrak=;
        b=IyJSwRg+raqiMXxITD7OpWhC0j+BUW6NgImOEJKHkz1Kyikzq/vKhUU7CCfq245CwE
         GF/LYaMGrupcl1G0VigcyyJhnszoBGXm574wKoGmQmiwA34D+MHFGwLMIRy7euxoZveP
         OjCuIjujZVgW9v2LErLjG48iRX8j/z/vPqZoizteWNs4Bn2JYOn+stV+lVUepjWBvmPd
         O7g4GOZFG0JsxPO3jiGUM6dPeL8nYOUXpzNj9ERVGxZ5+/K4aI4mCnRkFydsLIPcLZ3V
         IaJwl8XDb0YACNRsyMTqJSxLqSUFCJw1co7fpmPMvT4QqEsbrLc1NsIZBQ6qDL5ZGVko
         IZpA==
X-Forwarded-Encrypted: i=1; AKwUvBwzCynUH+7Yox65tdJqdWsUGN+r9l35zbmn3WajolbRtyROBmdFTiLV0OlMPCfRnkSch0omzMrgar8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPnXeY4SLGcX3hF2ndAyjV/Dogo+U+l5Hin1N1pccjEJPfJ3Ft
	qNedEsohplZg2PU41Tfx3NFVs+bK1ngY28exMS8TYDmkLcvg/8S7r4dAm7H5nD37Rk88BcaTOXd
	hO6xR6SyQhFpvXPalI5fL/7YcUNnjI4FJnv7Y/aYtxCc7O6/UP/LnDRfXD+XF0Q==
X-Gm-Gg: AYBFou0zY9hXHhS8cEAMXt59QbT747i2tsvHwqiUQqInUwdBpg0egdvnmGyFrUg/Fk/
	bO5y6u2O5iiRAKSxpo+VJ1LNNG7NrnWCQL7s6brihxXUCBxB9ZTtqpb8zH31EOs0t9SycuP0Z50
	E3hdM9JaoF4yInbGcQ8qJIzkn+fvK6ltTfXUADM15WfXdw5dSIZiHQMoAxuRxRSs7Mf3PIwSvko
	3EyuDopZIfmXCeOZ1NbOwIae0bA2NBvInya3nBC0Ptf0a5frLMt4kqzy0QjdcD+Q4ChFIMlpkn2
	kcAKEdg7YvYYQ4ujMDCVpzOOtUBifDDJ+LzT7BFDYJRM6aHO3DCDN6j5IXH84bLtjHWEuVlWTgv
	KgN9CyjAUuGHX5XKLnfMF4wJyHV3I6pH0H29v27kLCR1raUJYWEGeJgq0kYjuQc3PGdGCWBvMzw
	==
X-Received: by 2002:a05:600c:138e:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1fdb132a1mr95784475e9.22.1792658263067;
        Thu, 22 Oct 2026 01:37:43 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1fdb132a1mr95784235e9.22.1792658262599;
        Thu, 22 Oct 2026 01:37:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a207b29276sm58527255e9.6.2026.10.22.01.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 01:37:42 -0700 (PDT)
Message-ID: <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
Date: Thu, 22 Oct 2026 10:37:40 +0200
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 01:07, Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 11 patches for net-next/main and obsoletes
> pull-request: linux-can-next-for-7.4-20261021.
> 
> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
> CAN-XL devices.
> 
> A patch by Sang-Heon Jeon removes a redundant NULL check before
> netdev_hold() in the CAN RAW protocol.
> 
> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
> for the correct CAN CC/FD frames.
> 
> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
> any context in several CAN helper functions.
> 
> A series by Oliver Hartkopp et al fixes several problems in the CAN
> net-layer:
> 
> 3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
> pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
> calculation after a statistics reset. Followed by a patch to remove
> kernel pointers from the output.
> 
> The last 2 patches are by Oliver Hartkopp as well, they convert the
> unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
> protect the CAN receive lists with a per-device lock.
I'm wrapping-up the net-next PR right now, and this will not make the
cut. Still all the material here, after forwarding the trees post PR,
looks like 'net' worthy. We could merge it afterwards.

Note that there is other net-next material in the same status.

Thanks,

Paolo

