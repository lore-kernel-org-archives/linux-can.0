Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046325;
	b=30fdEvYuojUC1LkU1sMbTfRJP6biX+YarncS5M019b5SqUakgbhR51LZjwaMFB+NqdB7
	 lTJdliZJZaQqHZCKzhMqgpmX0M3tsW+vVOzB58eh8irYa4obFA8/J+VEXhcFLgZ2bCISX
	 ikOhiMppY2zYyad1iB9+9WYSL+wdeqEsozXRhW1+qRZInNlr7bHea5uFhxGNVa03u7QwR
	 kjPHBklV6Xz/WMC+BgVp9yhueZkyFCPIS5CSKRmHBfGPwirKgiQMYHOnfWPdCEbINrEe7
	 y5c2klk8QirK7OtfPxqvrde19svxM5oYeZslQaBz8wuBSoEIBj6yOcS523oxzqWzY6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=704mFSX16wC81X0dFjGpXon8/LqFUztOMihRtaFnr+I=;
	b=hKKaUXQmEm3SlCfc0Bd+7tZRHQhSxZYmQCtXN6l+ptPvNYENdGV1FpqXdOVjANa6oMZu
	 wZH1AS5rpAcIP6PMn1YJKDgjK0msWsASd/q8NXj5+vry9A6PT+z0rSJ58QFtUfqBnHm+R
	 2gEjbBqkmtT/FWL4vJQ8cESgtmCCvKNfaEitZJsysUUdSx9kwRBMe2LF9DQ3M0xnwTzBc
	 bO8m5G+lB/5vobkM45mkg7IhbybobeaIlqruwd/245ltlbqKCfWoAJ447kgZDUIJ8iDBF
	 A+PVe6KAM4RXigclQKadu5VwlCrSxlZhhlF1vvNu7PqTB3h1x728j+neGJYD3JK6JGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hqlBCLY1;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDC606A31F;
	Mon, 26 Oct 2026 20:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDDC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hqlBCLY1
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jD4r42pSRz1XM30g;
	Mon, 26 Oct 2026 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793046321; x=1795638322; bh=704mFSX16wC81X0dFjGpXon8
	/LqFUztOMihRtaFnr+I=; b=hqlBCLY16WH8063GIY/3fsNCiwGuwMkjUICRtXGM
	pQN6oGgxQcWa0hiCvNdqpmzoJzhhIhbhFQoLitOAoXbJm+oi5fz7lRgNTq1KNx4/
	uplc7/yufAfJ4z9/YxE4ZBlQR465VwTfkgyaCPjSCc/SC2m1ZOjDxFi+x5EC7U8/
	NqOMR15vlOV+z1XuIfb6XFfMQ0MDJ3Nza93TuAIENsylaeYMUvgYb58LPIOUzxz2
	Y4eFlE0V3S3AzXE+vAvE+zRx70JFU6TjHHGOH/eCIWv+9l6drBVoMCTfPq7lmFJO
	ZCDOkcSuzPtJtJIF/6Bu3WYHoKSSte7Z+ZWji/LGW9wi2Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hTa7JiA9mgOG; Mon, 26 Oct 2026 20:25:21 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jD4r13m8Wz1XM4Tl;
	Mon, 26 Oct 2026 20:25:21 +0000 (UTC)
Message-ID: <1428d48c-eede-4140-ae02-6b73e5b10a1f@acm.org>
Date: Mon, 26 Oct 2026 13:25:20 -0700
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
Subject: Re: [PATCH] can: softing: Fix locking in softing_card_shutdown()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <192450922df0eb9ce0cebccf381363680db65604.1793044027.git.bvanassche@acm.org>
 <20261026-adorable-furry-wildcat-0d5bf2-mkl@pengutronix.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261026-adorable-furry-wildcat-0d5bf2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/26 1:14 PM, Marc Kleine-Budde wrote:
> Are you actively using this driver? It's scheduled for removal in the
> v7.15.
I'm not using the driver. I'm working on fixing all locking bugs across
the entire kernel tree. Removing this driver will also make the locking
bug disappear :-)

Thanks,

Bart.
