Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311829C351
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700823; cv=pass; b=Z1Oo2SgcNrylpTj2v+WPg/K/5KH0gEehWiL1ZiXn1659RIZVM391/bofDmNswzOoDsoJTqm9/G9t2MNsMfhDMcLWIOicZz15XanE9arQ90Xx2Cw0Ih2mlGGPUOuMmA3g9+IJOqEFPqyMxm52LQwdi14ELXOQJEolvGjuZ3gGOQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700823; c=relaxed/simple;
	bh=TQt9a3ix2S5yQM8LyCRgsKOEMPQj6s0U4/SI5lsWHtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdtbAoZRXaYveQWo6yjIyIkagpBiuELq2RVBcn/sodTdTNBYABxfLOMOO1YD0JrT+HJ51aWmoqMUVnhCQzoZI7D9ry30VMqVpE66IdVPvr4YU1oiXxTMBjTZFJTg6nL1vIArPDUjVdVEeU/SHzSJUAtMflFF0o+PfHqMxiTduNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sihDlBry; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=zUPhxT9w; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sihDlBry";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="zUPhxT9w"
ARC-Seal: i=1; a=rsa-sha256; t=1769700815; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DyC88Y3B6FJWsuGorl7OEUHqlDzz6K+WfYp6RWLJA5KwXIp10Bihb1EyxaW2XMRenK
    uwgUTvahSlHNgQAbCFjR0DvY4umR5rxUshszfyN5x9EgTnUVyRCFIgOAr6P8p1Mr0Slv
    fWOgb4H8glasHh091HGs6EaF5ThO5SBEVzzNwcUEmoiC0attanILpXbcx9K3HVZbn2YL
    mtQT4DNpAI6WOFsp4u4GJHax0jBdTBKj9kl8Li3TDXiWJLcVSHVS+Fmf7CdKHxR5XSVk
    mB5qFDPcwJrLN5vGr73kjW5WkD9yqUNjyzgo6NY1aWpKRZ0jUeCkHxi83xqGWdPxcO1H
    fpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769700815;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jandEmJgYNF78HRNO+iyvoYGyGvRy6M8J6pyZ/X7Mzk=;
    b=LMejyMxCErJlydB0gxIwaBF8HUpoSKSbYIg4sFSCIocjzaGboEtLycSmEWTUxvxEbO
    dkHubURHrrXHx9CD7L8peib/16LbZc4oWMcFoli5uKcFLEAa+jaM+2mcm+bq1KbbNo5L
    NFg9Hpt1zBUQ85B7elDwCYCbjZH6n8HlkY0Bwi204DsuTWVzZ4YfM3vvBa05+km1Av5e
    IgZvApaYP9eYAEst1O2mie10FzZvjcUUW1jBm81KKkxcNJgkeqy1ugIqkDqwT0e8ocC1
    GE7Af/cVlvLFYsG7DrDkCZGNsgE+P1I0SCXc82u/8BoLimkxoxUsoboQLMSnJt25jL6c
    D59Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769700815;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jandEmJgYNF78HRNO+iyvoYGyGvRy6M8J6pyZ/X7Mzk=;
    b=sihDlBryRN69yGw2HAKmE+4fWXsjhGR1h0SiHd1y1CTumuJ0ieCDW614OQvv04B5wY
    OVRdYJdlYAXrEUOtXji2GZhwFEK7dvYtmVdHTat95cP3+IfnlFYAgw9OpUP4RtGmH9zm
    TAz0cLwVhCOpL2qii/7b9FXu+892tyAZrP2bQGBf+GQOcpunn1W8FEsiPnZMcktClIks
    jAvbJt4qF/bHnTT06OkkSv+v0wZmdbfPDX9SC1Wxk3kWECLR438ztS8cZvD5ZqjTpXrZ
    FSYe3jCxhSNX+L1zcLWqGy6TWP3jeh1dNPLKdM7WKhY9cdU9Bsi5NK4XrdlwIyYTS+20
    KTjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769700815;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jandEmJgYNF78HRNO+iyvoYGyGvRy6M8J6pyZ/X7Mzk=;
    b=zUPhxT9wY6KE7ZAddWsZTpZ22UfScth8AkzaHWX64OpOIG3QLhLfofoaSLJWuCr+Z6
    FIUuAnRE4M90hjrpcqAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20TFXZse1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 16:33:35 +0100 (CET)
Message-ID: <73cd6c37-c586-402e-87e5-66132a38a624@hartkopp.net>
Date: Thu, 29 Jan 2026 16:33:29 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
 <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
 <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
 <20260129-savvy-vicugna-of-drama-aeefac-mkl@pengutronix.de>
 <437408f7-95b6-472c-9a30-7a3ad647eced@hartkopp.net>
 <20260129-arcane-nocturnal-snake-b4f2ca-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260129-arcane-nocturnal-snake-b4f2ca-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29.01.26 16:28, Marc Kleine-Budde wrote:
> On 29.01.2026 15:22:47, Oliver Hartkopp wrote:
>>> Hmm, I cannot reproduce the problem with b4.git, maybe you can try
>>> bisecting:
>>>
>>> | git bisect start $(git merge-base origin/master v0.14.3) origin/master
>>>
>>> then
>>>
>>> | b4 prep --auto-to-cc
>>>
>>> followed by:
>>>
>>> | git bisect good
>>> or
>>> | git bisect bad
>>>
>>> depending if auto-to-cc works or not. Then try "b4 prep --auto-to-cc"
>>> again...
>>
>> Maybe that was a misunderstanding. It works well with b4 git.
>>
>> Only the original Debian b4 packages (apt install b4) do not work.
> 
> The question is:
> 
> Is the debian-package v0.14.2 broken, or is b4.bit v0.14.2 broken, too?
> 

I strongly assume it is a Debian problem.

I did not work on Debian Trixie with 0.14.2 and neither on Debian Forky 
with 0.14.3.

Besides the line numbers in the error message there was no difference.

Maybe the b4 package generally lacks some dependency.

Best regards,
Oliver

