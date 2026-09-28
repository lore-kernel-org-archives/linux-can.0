Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE234EA395
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623580; cv=pass; b=ZeZ1HEHF4i1JJlieUQ2bkTipcKskxBTSfS/di1or03WR8eiDOL1vFjODRQBn9/griP85GTdhV5HBK8E5W5/w6n9gyVtvGKWMzwVpJjcQVmCUNTH6LJ02qTnJF51gvEOZmNGqT6UIaj23uTxgPW35BwmLW/WsQAO4j5SWZtrP/BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623580; c=relaxed/simple;
	bh=NVkhDOzxRvtvXXYpEq9LN3lir7NDS6tvDESgPv9Icz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VR7iTou6O8+izbMvuLK1a/ii2qfJdwkz5WdftCP1tw2bPGGzIrK2sXYlYSGX0DJulImikg7DihTQB62eHDCtdOEdBbgSewHVAtL/95buOImWQvvhUBd/wkvQwBfd8SxEKkgSrRhcFLvkUF1i1oompdlumpOVcngZigNh2T0jtrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LqEPQ4dr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5l8uNdbn; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LqEPQ4dr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5l8uNdbn"
ARC-Seal: i=1; a=rsa-sha256; t=1790623575; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jl6QrTWp0GRcixaC86QFRuFH6OZ0Cz9Z57slIXfbooL7YEfEA7WqGkzrN61b24YCod
    JYPEAoGawFj4yBV46JzBF72sTDrN4gsz09+gjJGSYOsXiaV4NKKsvtYxUlWcNUM6ni1Y
    sE0UL0jfxpvu5dA0aDXXXaDo03B7dA0qJa7BQXIgLoocLvy5amBO/o6CXBpaDBS9aFlU
    EPbXP+ZBYAQtUP26CvVGDdlHZzfErJDjO+u3E451t4roP0JZkB74g7KFXcsD8mNQeNVF
    FzEaD1ysGoS4s6o2IZ7wdPtggZKMqZyG9XM0diKgy0R/w4eXPI40KQ1i4qcr96Bd2ZKd
    kfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790623575;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cT5sAqdrMGMw2aj8NST7uWY0CLb3rArNhXuHzKsoS2c=;
    b=m1wIiJZrSEg+MjoQiJjTmbdOp7Tcx33YlVCkNX5MmsfiED2PCTuP9yY8Hwx5qXBtNI
    ZmxH+GK3++xc0O6Dp1C+HHA5vhHArphZJKR+OrQi6MaSoSzG7HQF92gW9n8egv5z/5M9
    lpo5ALbxdWk22H/absIOohmL93j0zxDrwaXNYMgyXBi8fEZuiLwp7pAAd5KEiHMQS8gO
    GhoaLgJadGl5IvlHGnVslVlnmhFqdgXrb6agBnXRVYLjtTlGb3cplPU9V4MJhHjMPwVr
    qNc0zKipaY0iekp4r+G32Y3uYhTQQ40XRcicdL2NqC2emKGtXM0PdclrEyQONC61FRnm
    3BMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790623575;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cT5sAqdrMGMw2aj8NST7uWY0CLb3rArNhXuHzKsoS2c=;
    b=LqEPQ4dryJiRWWHR4QYp6pAYQgIyU0+aaEfPFI3bvjdVUiUFdp6iBhpMK8Va2ohZo9
    YJuyKVfn5BDhF6wUolJhvcYPCAdBm0/BJtlZN835KnHFAi8fPU2b8YEY7y1Sd03tZcrv
    xEkDWFGqeQjsndoQ3LcIgmsYzql+cSKtaedd9RIz+ydh6kBiNm0C6O4gRTXl6uYZjkzF
    eoO8J7Fvr+PPyTsdQ7s4YRHCuq7ftsL4dCU5r4mhQR8T8XXpbiRkY0jWP5wT11U5bCfU
    FGPtvrGIOPzpt7uAaUqyQIaz2xd4O+1Q/eaXLc9HsbMAdzPSBn9BmKsqVh2H07Lt58fD
    HY/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790623575;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cT5sAqdrMGMw2aj8NST7uWY0CLb3rArNhXuHzKsoS2c=;
    b=5l8uNdbneEs8VB5yovY+pYc/Cg6y8up70awyeDGWZxUcje6n8FWEH0RQEXk3vTKhll
    cl9VJ4uTr5y4UbjcC4Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SJQFOzD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 21:26:15 +0200 (CEST)
Message-ID: <c3fa6f4e-d19b-42eb-93ac-bd694a666aa3@hartkopp.net>
Date: Mon, 28 Sep 2026 21:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260928173105.51765-1-socketcan@hartkopp.net>
 <20260928-rhino-of-marvelous-honeydew-7abf71-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260928-rhino-of-marvelous-honeydew-7abf71-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.09.26 20:43, Marc Kleine-Budde wrote:
> On 28.09.2026 19:31:02, Oliver Hartkopp wrote:
>> This patch set aggregates the open stable fixes for the CAN netlayer.
>>
>> v2: restore non-zero UID value generation for isotp cfecho handling
> 
> I'll send a PR soonish. Once this series is ready, I'll send another PR.

Thanks Marc!

I've updated a v3 - maybe sashiko is fine now :-D

Best regards,
Oliver

