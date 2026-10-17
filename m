Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADC3AEF51
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224642; cv=none; b=sUGQdztmeVfwKrbFsZV4S71rZ9QH1BepFHRwV8qUDA7LZhaKulZBIBAQ2fRXHm8Ce8IjmzOQ9yK1GcO+9yM3R8bouMac0859o4By+4jkumMSB4khh3p8tZhP9HKMxYJnQAp4iF3MbfXIan5OTwuVEaFZ9uYWqA9O29TBCp30wkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224642; c=relaxed/simple;
	bh=LSrld5Agd/ciynuf9D4CLiDK+KowNdcf24U7fZm3QB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvPWcWxL9isqH59D0+IlpPyzkY2dMUzT586FP4h3kBuIqDMCoG1q6FXxoN4gnO2a5BRc0yNyIeSJJHLgLkr8qJeS/ep5fFDj5x4pOdtBrtBmsX++2cNzGHHCee6+NoZR1gziW5/ZllgND5pRgU7sNkxWw7PTjRmxo1G1V9Z8Obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+0tPp+h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I72Mf0qh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+0tPp+h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I72Mf0qh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6p0Rj3086972
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 08:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/ri079eO4FY+csoHfqAMZtagT4V8asc/A6pd2kzhyw=; b=i+0tPp+hTTOZjkK5
	MAEL+J/w4c/vFLYwXZ+MOQLBq6MqQ4Cqk16foWDHZXW5eUduVCUaeSBesLbtuz9K
	F3d7QyjD1q2yIh3qg3J4cLWN1xKWNwMAyoSFEdMuUZvOhzaVl1q6FsQBx2ANjLQn
	OcNIYhnBfUvS2lcGzYNTN7LmZ65IqgyKSRXbSp5HH3eE9+zCwBgB3C2PK/QWAd4U
	zmbcW0sxxd9/uCmIdcbAVgMxZhO7c/gUZTQQJyUMw4dQJEN/FwtZ0W+/Pn/ah71L
	pJSODgci1nVNEUDBycUbVO3VKppWzBxXkxaeZ7AjLTXMs1rI04KnmvNqZOS9/uln
	irh8BA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k0bn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 08:10:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b7e90fef1so33646466d6.0
        for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792224640; x=1792829440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/ri079eO4FY+csoHfqAMZtagT4V8asc/A6pd2kzhyw=;
        b=I72Mf0qhxOI6UlSPqs9AraVSzY+STJ2uq8ZA1/4ejxW4xDgJveyN+JWHnS28OtAkGi
         oY8tQ+ClzbJki6Z//sXUcCHk5IxvWQiCHVq9417FCGvopZdK9ipaA3+0Rb1F2jtLO63t
         5HplF5w/f1LjIUViSWK4nBYLtVV3sc1IabCl5DxDIpGGAsINM+hEohXH/Hj79Nq9tTAZ
         EBa/YVaMJ+BJLSYeh/P+kAKtk7hfaOd5vNOHj8rYRQZ744ecY7sLm5ndJHYekKd2lP7O
         7Hr/EJI8JAyQfzfrRSCKu03tllzSkUBRyjWNqKevoQSzWSn/sJebHoql62JIHMDYGPH4
         oVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792224640; x=1792829440;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/ri079eO4FY+csoHfqAMZtagT4V8asc/A6pd2kzhyw=;
        b=bMpvWY83igagrs4f4nGCM+HPG451fz8WyRLUeTuBSNRjI+MeDalEdwwORAa4TC0yX3
         RsZiaYo6zQ7LE7m1Qee10WtxS7bsvyT8setV+Pn8Oi5LIwYjq6NoaGCGaSFu5bLg3n3U
         C295r6ygnSVFXPvlP6Xr0kbo9681UT2tXZn24bPYANc2TLTzw6soa0S7uiroIDcM+l6m
         eY2xtOKWncu82fIUSzkLZkfho8cIsxqHOsKOOLR8S0jE84SiCUNaYnvVvmftu+w0LabX
         8nrgRD+Jc4lCPpufM/a4EfC+aor9g7rpCa21zY03cLXiUHT55oal55ysyq2/vVKbzj8w
         ehOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpUOukOL75qScukX5/wFGDefuYbJyjw5+LAyiCKqTYD9QSU8HsrRUEx6qyrDf2mT/LoIB0kvhGzS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/C1/M580ZMmLL589PNvVAZQ6QeaL99Tun3u5s/pbFe0rtEI5t
	7NgDS15zD8y4d6LPul0Gu/CtW2Dk7fTpo+N8/tiOdoCAFu7N4ZZJ2JjFesysR/JBuexGrMavjYt
	BncvEVeDnBOvv0JW80c9UYZUJoZ0pkqNgfHR6/S4br8th3IVb8g5JU/nbDoJlKHE=
X-Gm-Gg: AYBFou3aZzYOEewe8LihiLiKCjbnnldmDdj7zes4XmjyIB3NHTXYQLty9OxttoIBVmR
	V8AOSk1/9cAu+aUoEqdDTJvUmzGegyGJ2gTfmO0F2QhvOBdsFjOCDHCDv3x4Cn1mNJC+aPwnpMA
	HssvApgW5WTX0G6y0ZSIdIaRsv5TaFeV4NNpUIb4UQ7EkOCR0G/IElC6oBC1ibYVWnFKIHFYKMP
	xjmTA2ZKGWy4kJq96Cg+rTU0rVzqlWaZveAAVrRrgVLoQj85QCvU2rumvrTvCfO7Xk5dKf5H79D
	zWvuRgJpWtR6Y+OLIVQBWpHUuB1ScDIRBm8Rs2x0ZmAjIpJOf9v+tWaWkd1wM2jvXS8A1YfW87M
	8LweOw5wqU/Ns+a7mSMRLQ1FNaNE5N3+BqYwhPiwJf1OmMlefjGopRWu/
X-Received: by 2002:a05:620a:4495:b0:93f:2e81:2217 with SMTP id af79cd13be357-93f2e8128b2mr120962285a.36.1792224640047;
        Sat, 17 Oct 2026 01:10:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4495:b0:93f:2e81:2217 with SMTP id af79cd13be357-93f2e8128b2mr120959085a.36.1792224639531;
        Sat, 17 Oct 2026 01:10:39 -0700 (PDT)
Received: from [192.168.1.16] (46.150.72.42.lvv.nat.volia.net. [46.150.72.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471b06sm11128617f8f.5.2026.10.17.01.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 01:10:37 -0700 (PDT)
Message-ID: <c624d8d5-3362-458a-96db-0457b25cad53@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 10:10:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "magnus.damm" <magnus.damm@gmail.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
 <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
 <TY3PR01MB113465234171180FFB5F1B6FD869B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB113465234171180FFB5F1B6FD869B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMiBTYWx0ZWRfXypdhi3b0N+l8
 feG2Tsx8WCe6kEwxZL8LJjUIrENfcSTA86/2yUyUn2UD3hFvHM/vVQmSNrbLvHwOJ9vzsl6GofP
 JbUo1dIBAPQDXs+iNQpEkkpqDanCzYMel+jsUwG1tKaZKzK84bXNy3ZIUy1us1pB6EDiOa6J3a5
 BJW+tho03/9iir0YUuoi1kOOgComi6bo8ZiWRb3daJ6VN7RDuq9OaJmCZeNnM33km0gsLwoZuz0
 yrWinV0kXAir77o30Y8i02oFYRt1RUQP2d9Snq+8+GvU/rpndhlTJXC5WUZb+OfIJbpPAvmUFOL
 cr9uy44PwXFvlhNuk9nIWSYChPp4930mb00+LF3bRvOHUBAAS1d6wKn48MR5BHsGSSBGcfqYqXp
 hWuN5jwb3w5zjpVkhS5vzLzSPxXUeKvJ05HJ7J5QO40i3bzORz2sT/asPyeIsjkUo2OlSDk6Dn/
 jcVvTsFwV4rBZSvsDJg==
X-Proofpoint-GUID: Xu833MAiZNYLN_73YIVcNYrGlE5NrDFB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMiBTYWx0ZWRfX9Sg4Ur7/mL1i
 E6hhTfd7mdUWlN8l7Gh7IxLl1GxPj6qHqVZsPqGljIW7XpUXyETj1ytt7g8m53zeMHAD3AI5ZIp
 WbkBIpJ7QEZr7oDU7ehb/soTENtrts4=
X-Proofpoint-ORIG-GUID: Xu833MAiZNYLN_73YIVcNYrGlE5NrDFB
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad32d81 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=/kTH1SCY3H94FTY3n2CK6g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OvmbqCCc-nj-YtGC7z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170032

On 16/10/2026 16:12, Biju Das wrote:
>>
>>> @@ -294,6 +295,25 @@ allOf:
>>>        patternProperties:
>>>          "^channel[6-7]$": false
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: renesas,r9a08g046-canfd
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          minItems: 11
>>> +
>>> +        interrupt-names:
>>> +          minItems: 11
>>> +
>>> +        resets:
>>> +          minItems: 2
>>
>> Discovered by: sashiko-gemini · Missed by: opus-5-5, gpt-6-astra · Confirmed by: opus-5-5 Should this
>> block also cap interrupts and interrupt-names at 11?

Correct.

> 
> Krzysztof,
> 
> Do you agree with sashiko's comment? I dropped maxItems based on the review comment [1]

I asked to drop maxItems from resets. Why did you drop it from other
places? Comments from reviewers appear in specific places, not randomly.

What is the upper cap on interrupts?

Best regards,
Krzysztof
