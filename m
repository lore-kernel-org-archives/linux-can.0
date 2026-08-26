Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BD43BDB8
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755218; cv=none; b=c1EuaTul8+63iSSNvYy4jrWQe+ro46KDfnDG1p4+6kn6prlyON/63IUv6ocXcOZCegy+gnNMCQpJMb6iSeevZUdSx0RXnme+ogpztMbhXR1bZMh9/9uRBHBB5VQoMtGFAOGi9u5p/85dVfJvbWnsPe9ehHaS2eFz5oEN4ip61fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755218; c=relaxed/simple;
	bh=/ALipkPSPEeThb980qLYu9ZcubQrlYYu4Pidz3IOIrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfyy1bh2+PJHyqqH1akRkzIi4XeVQI4I2qc9XzgD+bYkjkTGkGthNVGrar9oroczlNRpAcNwW5WiiPV9B4gQRducSzsXKk4Z4bNiXbjp75rFAkWk2SCU7CqadRVi4NMqR6V5NABWki99qKlNqXyH/E1ZBTC39T/PIfkltNp5tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67QEdu1D095284;
	Wed, 26 Aug 2026 23:39:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67QEdugM095280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Aug 2026 23:39:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d2d59bcf-0c46-44f6-aafc-b5df22fb7b55@I-love.SAKURA.ne.jp>
Date: Wed, 26 Aug 2026 23:39:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
 <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
 <20260826-dangerous-keen-cuscus-c51817-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260826-dangerous-keen-cuscus-c51817-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav214.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/08/26 23:26, Marc Kleine-Budde wrote:
> - consider using "b4"
>   You can use the b4 "web submission" instead of using Thunderbird.
>   It bypasses all mail system completely.
>   https://b4.docs.kernel.org/en/latest/contributor/send.html

I have a question. I use Thunderbird over "git send-email" for later searching what I sent.
How do developers archive what they sent in local environment when using b4? Do they Bcc: self?
