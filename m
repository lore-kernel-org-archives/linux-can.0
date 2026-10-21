Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569877;
	b=c6cE++zVrKPUjmmjW5mSy+aGiQcJEVgtXGzZ/AxlJrVzm2jzC17xCfRjhKnavecyVoqQ
	 ZCquflnhpvkIToCSrK5n2ZMElCWxYM5Fu+OZm0EqxdLv4rU7u80NCnz5wx82+4toWmOik
	 OBTIUgR+AHlkpme1HoFvX4mXnq9kk3jDZh9QsL2mywk3vkzJMBsJJz/tIA+eHzBDJoPyH
	 aZWYGEiPE8PrPsIVobMifwYgTN/8C+EPSnWrb8E6qO5JIUBigthav9d/BkBK29EGoCf/m
	 bGHEtr0kH78aMiEDK4U/98KlkiNlcxvDEyASbjUQHggM0CyqjbyU3481fKv/U25/3Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569877;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pGkOUmftey3a5QiJh8I7cP2Fv7mua9fmiyASg+Wy4vk=;
	b=B7i/4hOSSVaQd+qF0eufzNSEicAS9qy4r4YlKRHPME5wGQ5sg5Gs91ihNx9pTVItl1UN
	 4P0jIFScq7nFCHCtcC4ysXYvRN8K2iD5xjnyWjBRFPXnAobKGK1asD2kJb1lYPr75SxXB
	 Me6IFjgqblvyJZWyQR7CS+MzjnxATGDqH4bJUEbtepzxe4QTl6Q3ZZbZF1FHFjGzd8vQc
	 /oFMW9S4b2dRi8A+LT3X2pr8JimxSiTASIOoeZj+DkV4lGC26pZp2n787xoUs2bLmSoZH
	 COiWJeM+f7R53+Bj0OkSl8T3E37ZRJNfIux/FckG0rqWDyAGjmS0MrTetC34Syog51Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AEUsi189;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vRegyS58;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.22
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3988606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3988606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AEUsi189;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vRegyS58
ARC-Seal: i=1; a=rsa-sha256; t=1792569869; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b9kSolRPfqSg0WAIK6l0QwSojWAzAMtzUNgwASg7CwP7rIYKr1qzPpkijLsBEeYGzz
    AZqchcg0uIWJRfbGtuImbafDnrh62rYoFRE+oAJcVFaZiCBQxmRJGENqWB60o1wlC7J9
    ggmwL8XfJRS3CAZX7RCM1pIbKIZhhnkuLr0E+ww+Zc57qjZF2FAppqifmaDjzTk5nsd5
    8rim1GZoX3ntAPtp2YYR+FccEsMC50pkZ9DBQIjoU2qiP+neS9ylPtfjVnswfiU/g5e4
    06/KmtOxkIcW2h1az7Pc4JfAMX1o+hqkttZEXkGe+RVz5wRHiGikuJ1PVTJnWlF1TZ96
    oS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569869;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pGkOUmftey3a5QiJh8I7cP2Fv7mua9fmiyASg+Wy4vk=;
    b=r4PE2jiPUD2G2idpuAqe8wYI32b5jKvpco8hSTyA2XjN5iwg9GAy6XHDYpRIk1OadX
    +QMB8NzjSKP4aF1XPY9l7agzHWYevvd91LTrPp6x5bOwxl5CWg5w5DKbebx7TLA6XymQ
    Nt0+zQbTfbceU5SyhNiuwVZ5yGoFHOFWOj2gbjjuFamnu7h//caOy/sWg2sjzQwxsfyT
    87SQMsP92dpG0Ggwx/UmZp+qNV39oDPdy3fLqyLZELLNZ7KtNwqj3f0dQksjDr5MJv7C
    7VZ7eBHrPpxucGOFVuZJaQuUPGxtim7rrsmEB9nCkdlA2dbPch4Vg8Km1Su65nrxRybO
    EJfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569869;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pGkOUmftey3a5QiJh8I7cP2Fv7mua9fmiyASg+Wy4vk=;
    b=AEUsi1890MHzC/JMuzJiNctXyixb1SVkhBPo5/24htee7/2es0izPm8n/sULulmIVa
    SpZUmvMA+7epvsa1pbXLQ8SqmlB7hnoVxK26BA67m/0mztxyxmk1HOhOEoPRQ8OJo5Dj
    4vWXHge0pb2lGvcOx8QP0vPTtPvpAzjNc6h3fMsFT2fsQwCviykLmi+dwzI7IL0dvlft
    uztrzMLX1gf8qCPw8z6bGLONFwGix+h68bY0Ld9Nc4xk5IH/POu2x1SEEOZabkBt7WT+
    oDZh/GCcrry7WFg68e2uQwgxVmpW/AYfUC/28K4E1uq86Z2Sp1Gnm2N4nmaHGyiiB8yE
    qHgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792569869;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pGkOUmftey3a5QiJh8I7cP2Fv7mua9fmiyASg+Wy4vk=;
    b=vRegyS58xigPHDTdeVrCduoPKXe1mu1pD845mX4ZOcC39506G61V2nMJvEVqpOOvOI
    iebrT12I6DVBROZ4n6Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29L84Sfpm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 10:04:28 +0200 (CEST)
Message-ID: <be2bd2c3-884d-4206-a395-a767f26ace11@hartkopp.net>
Date: Wed, 21 Oct 2026 10:04:28 +0200
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
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
 <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
 <edf7c988-4e58-4a9f-aad1-b5103bf235ae@hartkopp.net>
 <20261021-humble-hospitable-malamute-c41ebb-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261021-humble-hospitable-malamute-c41ebb-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.10.26 09:59, Marc Kleine-Budde wrote:
> On 21.10.2026 09:50:15, Oliver Hartkopp wrote:
>>
>>
>> On 21.10.26 09:36, Marc Kleine-Budde wrote:
>>> On 20.10.2026 22:32:52, Oliver Hartkopp wrote:
>>>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>>>> triggered when a CAN device is moved to another network namespace while
>>>> a socket bound to this device is released [1].
>>>>
>>>> Only patch 5 is new. Patches 1-4 are already applied to the testing
>>>> branch of linux-can-next, and patches 1, 3 and 4 are on their way to
>>>> net-next with the linux-can-next pull request [2]. They are included
>>>> only to provide a sequence on which the sashiko bot is able to build and
>>>> review patch 5. Please do not apply patches 1-4 from this series.
>>>
>>> Can you adjust the patch description?
>>>
>>> Marc
>>>
>>> pw-bot: cr
>>>
>>
>> The second section in the cover-letter (which does not land in the kernel or
>> anywhere else) became obsolete.
>>
>> Do you really want a v6 respin for that nitpick?
> 
> You can add an updated cover letter for this series as a reply here.

There it is:

https://lore.kernel.org/linux-can/20261021080231.16408-1-socketcan@hartkopp.net/

Many thanks,
Oliver

