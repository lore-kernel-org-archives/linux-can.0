Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051201;
	b=NblobPBCY8gj5c2GyAuROM8MjQVSWNgWzxnXYr/zWAiIHBRgGjKRYV0KNcYE7oyI9Vwi
	 v6lSSICC5tbp/r8u+j0orIgEL3tpLah447KS4Z9f1r0jSY6SlfcC7AI2I5iOyD6jkldGd
	 0U+Uy7MsjIkJB2Y5f+SEd1oxha0cnf2KDAejel577L4Sis2h4Q7Xs7OWgqTYkTc92PcKn
	 PZq2L8wQL8GFiDvSNayK4xJmN3Jlj4zRtz1g77I6BZrK2UdAiOZ/DwrKPLgIdT66JRfLF
	 ucZRroRHjXagHJZKJ7KdMNCGSI2Ok+rN6zuxiXnj5jGCdFIndf1zZf4t4uA5MpN9T8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051201;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=EMKZaE/XYFh3yT6HQAtYI/zY8AmONcVS3pouBV0eGto=;
	b=ItK4I8Ygh22ITgek5Jsc3Y3Zz3HtBOie/kylDyBQb+PMUJqWVBQ8ZMn7Ray9BMwwzKgT
	 srksoKvfv51rwLfzAv1qK4fhM6HAVk6dfLGyMLk/ZbNB3aLIN3YJxMf+dAdl6hGNyoeLf
	 9ogy3NnqbGLB8Fb/pqjkPj207cK0WT9GwRuEb7ENMkJkfotR05VwHARKplqhVXmlySBan
	 Lq/0g7A5lAP0EeKeFBXISfb0P34+LMLO2J5BMD7BaKqFhheK53Jji7VrnFRt47Y3jtjTO
	 xRsvOTnQy9YWWxTBexkk4KO032wBGHs538Z6+1BTyGn7LlnjJ1RqmICU2qgI3YNlosw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=aRNo6BGr;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6E606A31D;
	Mon, 26 Oct 2026 21:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=aRNo6BGr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E604B109A29;
	Mon, 26 Oct 2026 22:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793051188;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EMKZaE/XYFh3yT6HQAtYI/zY8AmONcVS3pouBV0eGto=;
	b=aRNo6BGrBEGsHg09zduodgDcdB0/hLQ65D1Gbqm5UtSVFa3U8H1bg2i6KsQ8B+zic1cI4G
	mCp+iemb+hSZSm1tyBEZzuSbILVR+fzYeNq9PZ7ETbE7cfYH9SWZ1BrX9ATwHGdoSZpqiH
	0qkFmtbL8Rg27kJciiC10UOIAW1uhINSYrVDmxcMmzXwh7C06W1r4HX7OCetUxIRGstJuB
	J2xc9HleSmPQhzEE9Ne/XmA3W+VRn1E5+YRHTu7VmwuHPrab0BTJu60i3DlXp9wjlw8szj
	ooW7dRZlgLyFC76DdQ2TZvtTsKyDdsllqL10DQTukPIJuhSTZemdsJHFN3qkOQ==
Message-ID: <8768c05d-417c-41c6-a275-33ac7f74e345@nabladev.com>
Date: Mon, 26 Oct 2026 22:46:23 +0100
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
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 linux-arm-kernel@lists.infradead.org, Aswath Govindraju
 <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com> <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb> <ar1bhpji35CbArtY@SMW015318>
 <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
 <ar19W4wX07p8u3_5@lizhi-Precision-Tower-5810>
 <4efdcea6-a099-46a6-8d07-dd5c583b962a@nabladev.com>
 <eca44457-d3d3-4732-977d-d30a408b7b66@nabladev.com>
 <at-0VK3LQ5c7rVmF@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <at-0VK3LQ5c7rVmF@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/26/26 9:13 PM, Frank Li wrote:
> On Mon, Oct 26, 2026 at 04:04:02PM +0100, Marek Vasut wrote:
>> On 9/30/26 11:49 PM, Marek Vasut wrote:
>>
>> Hello Frank,
>>
>>>>>> So I suggest remove it now and add it when need.
>>>>> Can we please go with consistency between these boards from one vendor ?
>>>>
>>>> Yes, I am keeping consistency, then ask remove it. I applied alex's v2
>>>> version. I put v1 link to show krzy's concern.
>>>>
>>>> https://lore.kernel.org/imx/20260319125013.2421621-3-
>>>> alexander.stein@ew.tq-group.com/
>>>>
>>>> Changes in v2:
>>>> * Changed commit message to imperative form
>>>> * Remove (currently unused) display and backlight nodes
>>> I sent you a V6 with those nodes removed.
>>
>> Have you had a chance to handle the V6 ?
> 
> Does first patch picked by vnod?

What is vnod ? (the patch has a RB from the DT maintainers)

>   dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
