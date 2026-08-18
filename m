Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A25339B41;
	Tue, 18 Aug 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092134; cv=none; b=kd+2InaGNThBLJuGguHiPa+BixhfNpb60yLM1qH5qa7rz0CgvLamGWFAWaMfSS4ZSEWv5eTHysUKxvW1Tjvg5Hspx/pLoKPMwYO80hvm/JGaZvr+NGlaHzucZ0Egl+1UtHe/1m1CPQcjeBe3A93dJkVSq7tcPaLXkuB2hY2at8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092134; c=relaxed/simple;
	bh=3qai0S/ru/fqSqLSJng0V4ph4AtwOiXeBr5ouG59JiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3PyPuvcDCON8h88w7DFhNDfZHTHVcJ3GCAf/GmhP6rZxrTSQnCcejTDpJaVDbIii5+XVv0uY1d4hG/7XWkSo8u0HeYgAkh5rRAR+6igq2yngjPIE4M7qiFoPZzr64kCVcAYF3G087wycPxcGZ47y7BG4mU55k8HnUKSWzCt8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id ABF801046AB;
	Tue, 18 Aug 2026 22:28:47 +0000 (UTC)
Message-ID: <c88e0f37-b9b2-4f92-a0c9-1ecee44d6d7c@enpas.org>
Date: Wed, 19 Aug 2026 07:28:44 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
Content-Language: en-US
To: Baul Lee <baul.lee@xbow.com>, mkl@pengutronix.de, mailhol@kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com
References: <20260818221818.49430-1-baul.lee@xbow.com>
From: Max Staudt <max@enpas.org>
In-Reply-To: <20260818221818.49430-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seems like your patch sending tool didn't pick up the Cc: line in the 
commit message :(

Can you please re-send it just like v2, but also ensure that 
stable@vger.kernel.org is on the email's CC list?


Max

