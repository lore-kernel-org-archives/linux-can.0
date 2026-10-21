Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792569025;
	b=CPxwoInM5rNrrfmi+y+9N/ndvtBVBpBwcZA823eEyhkbYbtZftc+Jpjob13UWUVDCHyU
	 2rjKJHpbeWPxOHJUzvI5Jg2cwAdnvSkkR2G0QrCgMx/EMhmdk/Owae2u5A3M6gEZRypsp
	 0zSb7HCW/DEM47DOvccjVCWtPP8br4r+CMW+f4+zK/78ygMb2HXAeguyTkmgUg3GZjGaC
	 jt3976ATzv4PJ6+t9qLCFhzD2tnBO13GYP+Vd/aGdGUETz/zTNwYpkxg+fdldC4RABBOh
	 8mYtZrY9GVe4UCgZBQ+tzfbLg8OPJ0+45E11uzQMp0tPe8y+vqLOU0VC3PEiNKkeWjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569025;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Cz9MiSMQVFS11NDjo0fsxj9WmkqfFEOGYR5kN/6URE=;
	b=G+sw2kbJE96IePIrMeaR6kvEtuuRY/bPr1j2RVxLNa33s5mK53lLRU6JguLwPlHXbFXx
	 P2EpUWNY598AHnDKnCOMP81P5qqBc1Cev7KHCOb+hlutZXzp7sHXO7mP8pKYo3cZ5aKes
	 jedR9ZXp0UFNvxHQaTqucRLOLSHfsIPaXhVxRJt1ZVVKAeZviUj91hl7RMshEzgDI8k3M
	 l3dc3xOCrz01+eSRDi2pdppE4N/UTS/HUpKg+hFjeBA8I+471nkKqYGywSyDUAD61LQxe
	 YlqPjAE0kgo6SvEhJ8XaigXy8Lyjqc8OfOvJxLYB/S8CsJDl6YbgXDr0c1Yyo2Fy6zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CZpF0gAa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="f/b6Fyln";
	arc=fail smtp.remote-ip=81.169.146.161
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF63606A327
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 07:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF63606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CZpF0gAa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f/b6Fyln
ARC-Seal: i=1; a=rsa-sha256; t=1792569015; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VdasaFXEhowWS1gWb0Mk0RFtcddPvo3IHg7gPMy9iWKPacJFprtG9AHAUUm1U5iA90
    YTNUEAkcwMM3/RUGK+dGz0LKmxU1z0FwKU/GPk1D1KcFilADhheIMa13pENPw4T4gvwn
    R9S1OEO7LcPjEspNxh5lkVTvLUbaLrVx6PWF4OL2WYqDn0Ht7W3iBajUstsu43fu4W6r
    D4kM8fvvEpub2k86v4AHqbq/wcjAfOtBcvVA8QCk8G4KqgyYbv5ZPVmdEin/UBnWIpB+
    mEJirUYqWzxGdlU4JrIXH4itRfdoYo6P72+gi4b7pXVeObStbyxJakpqqMQlXzoY37Oo
    Q3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569015;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Cz9MiSMQVFS11NDjo0fsxj9WmkqfFEOGYR5kN/6URE=;
    b=gGvlZAbk6ArmxaV/ZHLT6IITBZ8nNAFeRSCaPv+a6sX3UZ4zSjYG5jXY2yhRudI/WP
    I/E+bkaTLPYHmhkdVeglpATMFdl4oP+4tNyhGO64sQncN6dEkyyOX+htF1kGJMOqegG5
    +OaKdzS1UBeOu0QI5l+utzLBvKhdfYwLVe8EvUIOZ1Wjr9vPYcwlr514oEx2CKB8FfLY
    4ojd+naEoEJEybeoGMYiWEcyJMNhWikZfOiO2FJs7AfMO1lfpACD+egR7c95ElKXLYLS
    smWGNESkg7m4WsjEXfZw7kYT7n/wb65oEbvjxkEwUlBqFvAGmqdm5x8qXemm84TjJMz5
    /xew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569015;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Cz9MiSMQVFS11NDjo0fsxj9WmkqfFEOGYR5kN/6URE=;
    b=CZpF0gAa4f85MOP6ikBQBiBTLBdHLU4dgkXqUplDOZJgtv8CVT8uUpyjQMF68PF5h5
    Fvs0ApWh/XFCUcnVM5cJnvgW6mc2QfDdMqFwPFqeVQPSnFS3UYFE2uapiYPIIMhGoKe/
    WzEv7K9Qzm6idsrbOL6SP7vJfGwoGw7nzOzs5bBcEd9uADdJEmnfUQN7YnXK/6xVfJh8
    5xmCNnlWIiRF5yJGzN+aQxlujRmxTDYf2GDrTxjEXIdBl5MyNobjIO71I8CBUGDCQU/U
    pWKxobbmc1SR9rYL9/qIh90pW+78IUY6dOLH+yeyGB4EUHgGA2zMFe5EJuhPxK8ab/vF
    OIdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792569015;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Cz9MiSMQVFS11NDjo0fsxj9WmkqfFEOGYR5kN/6URE=;
    b=f/b6FylnnniFA8OkU055npjTfdmhZhulp0dK55dqrGBmD5A1XNCpx4IRF6FajD6SC3
    b12T+BKaCDPQlf8wabCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29L7oFfhU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 09:50:15 +0200 (CEST)
Message-ID: <edf7c988-4e58-4a9f-aad1-b5103bf235ae@hartkopp.net>
Date: Wed, 21 Oct 2026 09:50:15 +0200
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
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
 <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
Content-Language: en-US
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.10.26 09:36, Marc Kleine-Budde wrote:
> On 20.10.2026 22:32:52, Oliver Hartkopp wrote:
>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>> triggered when a CAN device is moved to another network namespace while
>> a socket bound to this device is released [1].
>>
>> Only patch 5 is new. Patches 1-4 are already applied to the testing
>> branch of linux-can-next, and patches 1, 3 and 4 are on their way to
>> net-next with the linux-can-next pull request [2]. They are included
>> only to provide a sequence on which the sashiko bot is able to build and
>> review patch 5. Please do not apply patches 1-4 from this series.
> 
> Can you adjust the patch description?
> 
> Marc
> 
> pw-bot: cr
> 

The second section in the cover-letter (which does not land in the 
kernel or anywhere else) became obsolete.

Do you really want a v6 respin for that nitpick?

Best regards,
Oliver
