Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD43D5227
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549360; cv=pass; b=FHKkP1sW8iCoFhBXeQTEPs7CyaCPESeOVAeISsUq/ZVCFOGBGaV5TkLvC9HgnSBYQ2p9u9x3OWhAfBNwl5dvlpab845wAynFFE7b2uBjHt2FJBGhceFdmeBKki72NPm6/sqnexgjy1uIJuXcg8MUYNx1KfpH1ZdLrRlqlDqmCoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549360; c=relaxed/simple;
	bh=nAT2MiyccIy/Awtz2HEw+yDQLW8aMA85naVUsCKkusY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYuebLWw5cC3G5PZ92eWpPNi/HU3X1JXTh4I78d7lEkTKXZdKN1GBP1eJiDgaqy8TvNt52kRwP284BxQX+2wPMRlKNbxj+yL6kdthHrFRBX3glvvnMxa0uOMQZnuMFzzRyI0610yoNImRipy2C+ACp2YMewEpS41qj77zF02DRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U2yvamj1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+v6ZbMKX; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U2yvamj1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+v6ZbMKX"
ARC-Seal: i=1; a=rsa-sha256; t=1791549346; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sSU8O7r61m09ed7gqhH/mp49qX2GFpEtgwqmM+JpH/+PMJh3Vi3xrvZp7JjCky6Bu2
    1op8T8cysrFkuRULGJ2mpAikmj64jSgzJsDcmd9tDH3wsOI12s0TazS3YD4R3ury+eNz
    i4AFtRgxIEP2N3Pz51g8py9/Ek8qksRjvFR1v466JKC1/6ZDNffbgOI2aoTfm6VJFcq7
    4yGWGFwBrjXeXCGTyYE93y3bIIpvHDzJ96uVsDhAs8Amw755OkyjK+EhwUlXxRt0SQit
    fwT/uuQPjusQ8KhaajWsPAkeH5ZjW/9678n68ToozFQrtlJS3AvIFnkI8eIk9GiPz9QR
    8uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791549346;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwDrUqSSOgm20hW21WaOHuf3qiJwRWWlXZce/HbaDRI=;
    b=qAM4UvvtiptUn9XRegJIwJDx39yC1AWn0fSAM2fMuBXkXDASdWyuYEgcgYhVx5aJ5l
    SE0FdTKf+EL3/NAZC/t34On/eUWi9W3efUv6t42aBeA0yYSDufYrCT/9U+nJK8Jm+BzJ
    HefLwNBmkfX/Y/z5LvC1i/3A3gM19bbANcRPPn8Tp703xeAtv+lau/myALV5FACVd2qB
    wGx5qN12JVfa3ypPi4Y+xZLNI2HfioycL7p3+irKnYoXdlBG+ZbKigbjQ3rlnuapE37d
    A/dSQiBzLiXB3HvXsxyeBPEVd+2VhDDqqfTmwe/aq9/gjN3+UprAOI8iDiQzS2wqslVn
    WJbg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791549346;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwDrUqSSOgm20hW21WaOHuf3qiJwRWWlXZce/HbaDRI=;
    b=U2yvamj1xDc4uIcO92UYSzYejZq69uKVZbwVl6PtIed+DO+h6s0DpM/qEoCYIPDWJB
    bJTlnrEhGOunI2jXM7ZOb1yQo4b3vlQUJkCm32C0IRI4j5nOLFl7C0d/TUS7e7oPilfA
    DDXN4mnvE55vQQRQfLuWfr4PLimZbN9TxUF6oA6jCFBatLokwGum1cKH7/yVwsNsEYlS
    W8w6ZxSPVH4qoyqlt4DopXppflYBpp9GXQm4l0yxV/8lqNrUdnyovFREb4oYeFL5QUPj
    E9DvW9WRcqRBxQi3qMN3Kp1zj9FNnZnilh9pn7kxVNC4YRq9O6C5K8ewWjUrcehMaUf4
    gBrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791549346;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwDrUqSSOgm20hW21WaOHuf3qiJwRWWlXZce/HbaDRI=;
    b=+v6ZbMKX/gwAOcXYkAeyUpA9sYAQ+Xn+sBUYNogwFKg9901nErznCnwpg+SXTVufHg
    Wbx1m5PNB7R+0mU88nAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a299CZkV5M
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 14:35:46 +0200 (CEST)
Message-ID: <3d368341-1fa9-417e-9d9b-e7b4227e76f3@hartkopp.net>
Date: Fri, 9 Oct 2026 14:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
 <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
 <df3da1ab-9a03-4720-9486-f5c5902cb9b6@hartkopp.net>
 <20261009-furry-coucal-of-rain-04a98c-mkl@pengutronix.de>
 <20261009-exotic-tremendous-vulture-225cab-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261009-exotic-tremendous-vulture-225cab-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.10.26 14:33, Marc Kleine-Budde wrote:
> On 09.10.2026 14:32:54, Marc Kleine-Budde wrote:
>>>>> Do you want to apply my ml_priv patch - or do you want it me to do the next
>>>>> 5 minutes bevore the PR?
> 
> I'll send a PR now. I suspect we have to work on it anyways :)

Let's give it a try :-D

