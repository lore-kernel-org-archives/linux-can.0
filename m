Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B03466B5E
	for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052668; cv=none; b=JN+/4qvSEnunG+yaG1DjcnwwgGBDcb5NyVSTnRipqV2UKYQvRljTkkGH2bZr6ZvNs+kiufcEmBqImOdyfpoQAoJHTeuyXo7kaTYgY3MHOAQBkuuZmU7AVdD/XNUg4O0p3gbkHXFoXUNtB6U6ojZQlTeHEpjM8I/YkBS/YJ6d768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052668; c=relaxed/simple;
	bh=34Tk8hFf2kmRMBjY2LDB8H6WrFBwxCMdp8HtQJlrF24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw5pqPB/Ic5adhGvrh/j0SGCICj0tjtVrejx40z0hUJp9jMsZHYc06KDcmvp8nu+IPHbz4TMaEZL8BU1dWOPQ7jqbPzr5kAcGEZJMlxg+m0xwdJYtU+Wyn8vBM2FFW99gFDsLXu3Pg2r9aIdwrd36BKrjV4BkMusYKw8kHi7Y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BFG6MyN0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BFG6MyN0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4815bce4652so2815975f8f.1
        for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1787052664; x=1787657464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzUhoMzeL3A3db0AUGhPTEVPs2wp/05yY0aTmKXk1EA=;
        b=BFG6MyN0Muz0meok6YmouVSAlvzC67kX/ZV00aJNBXUKLcK9yD4amtBelxvPxyZKiY
         fITYL+iGPBG5vuRWglVAGUT9miBkALEsA/nEPPOfxWSbWjpaKM12hAQFvROvqrB75o/9
         APLrF579V0PspvENvn6IjUxXKZ1L7/4azd24KGviT6WtjidCUshk48XBfahq2PW6bmIW
         T6og23XktrZoyTPjWT0k354AFmDi6kOMdlO8QJu5Oolm3xdKbku7UdARVEPcpPDbQM0F
         VSb4qbBK7D80AEC7mvgAevm7WLeLFnIh9Raqs6m9ahOD3vqYX50NH9Ab2doZY79lhqrf
         FVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052664; x=1787657464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzUhoMzeL3A3db0AUGhPTEVPs2wp/05yY0aTmKXk1EA=;
        b=WWBX1jTvk7hdmUGM8NJ3RLXn8PLQpqcBLgFGLk6wQN+vQLRxaBr2A+sRH4v901TVnE
         GxzycwAtLKPkXvnFvOE+kL65eUSGQJiA+9PsJvvBiTBKleJpYnC6ydEM0gqlNpDm9a9w
         5UvKGYKXIK0p1Jm3gxsxrk2VELxeNghK0nrTHQk1C8SfGPkjuPgIcOCPQoq/5d+iI/M8
         y7+vMyJF6hl01+WFgkqiRo85+AGAKJRivdbdnQpeOAQdTOp0x34kcp00LTZB1F2lhGu+
         1kXVtKCrGjQsvp8gJXN3jGaeGSRXgeAzc9fPnTxWUH5pbdkomoWDwtdyber8dzdDaK6p
         GoEQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro43kEO+zgOToKHkaU0qGpy12GMYeQ87aWD6QKtuj7AbJNtFOJF7Zog3JJHR/bXS4LwLk9MRudkl+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH2avvFlYRWJrReMGptCJQ8l5KNnXeUf6zVgXh1cYgKSAtUVB
	/ysiPy23slEorSyi+WfuiQg+EuKj1H0lNcgqEm0MFfBHOfGTumLLxgjp8Df7O6i+oAw=
X-Gm-Gg: AR+sD106rrFpzAeGXyt64qyA1B9eMq1nNyFUX7Y+qCFLpmu5cNiqCP0o0aKNKy8N/Kq
	TYJ5/Vef8fPag9smgzuOv0A3PwD//gX0TnH1mUQfPOiBMpQ7AcbVrFkYzxpN90cljobF7W9eU82
	gVJ+sSoHRHbizjZ3MPYadqd6Hhp+E4uU65mU4e+SBsNDRpK0PUZzXEJ+sG4ASmi8g5HG1HWBgCu
	pX3x52WxJOnK+w3EUJA2XmdZUTmcXgcrRBezKaLvWIt2m8e0MPKDMtv/0bm7VJW1VIxwrlwiPeR
	sBlCqov+b13Meig0YdL4xHpp8iLDyFpPvCVn0/n8AC/pIIwVkM8JNQTZ55VkgHITuEQ3f61RiZ8
	iOhH98ihZ5/CiO4Immw/74jk4NQ+JOHZMkdj1ZhW1ngmTmhdPoLZPeznO6uF2IHjR35feBdxpxc
	j8G2VzWiZQNETkKG/yEDga1UGvo/VnpMzAiXr9ZCuJuquylGcQ9kpDBhQcaPSbvH1Bh5ZvVoCro
	E0eJ8fg4yqERBVB0Zntn44hBmwyWlbQG4F9158rZPPV
X-Received: by 2002:a05:6000:41eb:b0:47f:91f0:9a8 with SMTP id ffacd0b85a97d-4816079ece5mr60246879f8f.23.1787052663977;
        Tue, 18 Aug 2026 04:31:03 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6400:1700:1386:b860:6632:a42b? ([2a02:2f04:6400:1700:1386:b860:6632:a42b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm10674828f8f.27.2026.08.18.04.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:31:03 -0700 (PDT)
Message-ID: <f29963f3-54af-4eca-9122-fe757c00a90c@tuxon.dev>
Date: Tue, 18 Aug 2026 14:30:58 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mailhol@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, bmasney@redhat.com, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <7533fcaa-c676-48f4-924e-bba9195d4871@tuxon.dev>
 <20260817-tricky-monkey-of-admiration-3caebf-mkl@pengutronix.de>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260817-tricky-monkey-of-admiration-3caebf-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Marc,

On 8/17/26 19:59, Marc Kleine-Budde wrote:
> On 10.08.2026 16:00:16, Claudiu Beznea wrote:
>> Gentle ping on this series.
> 
> Who takes the DT changes?

Apologies, I missed to previously mention the merge strategy:
- patch 1 should go though Renesas tree (taken by Geert)
- patches 2-6 should go though the CAN tree
- patches 7-8 should go though Renesas tree (taken by Geert) as Wolfram already
   mentioned

Thank you,
Claudiu

