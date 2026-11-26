Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702547;
	b=hK3ZVU3KKFhgQrcWTY7g34P6kp2y9GqB1pSqyQQApmbqg8jy4uzKJWXbEuOK4x9XnNCu
	 SeGWHTnOj3C/QTF3kUX48dOwcfyUjg3VJwmrEY9h0WOQl87vaLkarN1xHu26MotaNmUP6
	 ttGWjrOfkweY9KEsPvazUWYYHzcm0PWZ7UYgY2y/Ri/vGwlthAe5zl67W4LBlUl1+O+Ar
	 JVnCLYHbyR/1NiBP4vE1xdruvQvP8LWW5jGvAAbohYO8vqxsLNqba5p+8cbybHNmMFenT
	 bEM261RxtDBePl6vDjwCJs/tdwsTi54c+0CO26ymdhhwKF5mcGJKs9TSgRCqXzQxMzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702547;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LVzLW1gzyeQ6HMEDoCweQ+7lKqZtcED3bCw7TBJO0f8=;
	b=XdFJBdYWO7pic9PLeWhaNa2u1lPB6f9Lz4hj2Hd3gWMSU0uWEL3xsJDtc4PW8VrBziUK
	 0TXCsH12tUvFSlqgM3S042A76iHDrKLaJOxhKCO0vqG+HH6Ijf3QfZWT16g1WPixMe2Mp
	 46BVYbCQOh8L31nW3lGTGxuYuk4wPT8dtWQhEiKDyImS6u5kHnZeWXVMMQaaguflKq+fG
	 FtE5aSWt6TgP4r0PlkdDgiriOQ+t8GoY+9peUzF+CB6GWgaL4LQLt8/VnrNeKt+IbyMWW
	 wo9JB8eXruxJleIiCvS1smPY2CdzFOq2bXGLbwvrfJibG1EvGlJPQK6J6FfUnO/2/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vt1B19sW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2zcEPJ6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE60606A338
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE60606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vt1B19sW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2zcEPJ6
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVZFC2758459
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 14:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LVzLW1gzyeQ6HMEDoCweQ+7lKqZtcED3bCw7TBJO0f8=; b=Vt1B19sWIBBA4mMW
	vnVJHGWXmelLmC7j9BsDV0rHCG1XZiAo9Mjc8NNfGKQRkudTdyJaFO6fQEW5Kq/p
	UFigf+BLWjKt87EiEaq8w05xNwSUUKucQ2jBzkU8CtxyRb7GzUk0Df4blpTzWoKk
	iXwfaRxxE6jIng6Ii+ZLk1pGMzXdC9qhRN7nbgAhexaDMTRT1ydU70V+aAjxEcJu
	LXSOiQ5MS5xLN2D3xMBelA4kdTXDaQK2y/hCB26gmUW9WokQivphwXqJMXr0cui3
	gheHH4YotDyfMyuEisLUnjLqqljhA6DBgdJktjmikGhgwla55DI/iLiGvLeMaf+/
	4Pu3gQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvqu9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 14:15:45 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6790b1d3bc9so11613835d50.0
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795702545; x=1796307345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVzLW1gzyeQ6HMEDoCweQ+7lKqZtcED3bCw7TBJO0f8=;
        b=O2zcEPJ6jI/T0F5UgRn19bhDF3s6TlHA7Djz/OBkeevV8Otlr0m1eVKP7JrAiCGuq0
         A+pc4HqqgBTJMJzGxTTj9zMzIqx0rkroqix6beabLgspv5S3TC/elS3lkH3rVQLy5N73
         t+n8h7qu2jKNviTV703EGDe+wN4gywTLDOnxIkZ9qPfLaZhxf7Yl8WESP9ujy1DA9ikb
         vui4Qgn6JEzTUjgc7K5K7akUGygnH0I/hEBWFa7mdScDWaL4HFLm+ksU6SqcIEYrbJLd
         6IHDqd48WPiTThUMq9akn7APkKZOdcrN7tmHcBmaOVVnQkz2rRW2bKo+N7ch49tvh08E
         MmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702545; x=1796307345;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVzLW1gzyeQ6HMEDoCweQ+7lKqZtcED3bCw7TBJO0f8=;
        b=U3yUcO9VGIZuJI1GbF5Y4R997hv3JKskGp3FhesBnhGTE/ZonBEMIy0Xnf5R0kBlGm
         WGQWvzq1D9RI4Sr3UjwZNffMM6hNhFepfZc7xt1r6EBzq/WHs7Mwzoko4BbYhgTlIG07
         MNkhCRC2Rt7cKTGYi5gUvJciaxlU6TDpqmfDhKj48IeMd3zwqrCgGQ8o3WMSDTleEKM/
         AWmr6jMNooQ7Ik15/dvFofO6dsVXTYToZV7kLJfZ1P4HUoMXMLzpRghHBfS/Y7u9q0Wz
         FVvJmhAGtDmpLWDJbsKd0Ut48zWRHHo4ZNZ9756ZeP1X9FJN1N+AJa8pKRmpzvB5AQu9
         6xpQ==
X-Forwarded-Encrypted: i=1; AL+hErFNYx8fA9jbwZw6EzXB295UgbIuztrpjjrCvb+kvSXBJ1gnv2eqI/x7Vup3Mu+MZLUonUs9Kb7dThs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8veJiig1l9kFkMWKpJUUMQpAMbvwFMznz4dPud1ggWCREAfGXE
	Vtw7QQmkjfHmpvP6AUGHewVwYOyq0RCb6SWCvc1fU5qqxHA8Kk8M0py7l+XsojecF84TjjsFCT7
	ojxsDNtTBZHOXVA80OksrTRRm2s6lxAOSrJxlNPCiRajTf6oHzw5EJYply1COpXU=
X-Gm-Gg: AZFdTZflhPHwL6myq2QDeZL3lcxKNZUxd/egygjKdGe/OS0PtlPqIEOlGFg3rgMbTUD
	JUqEUH7TIyKa2Zq6kA1bA6ddKwK6/jmYLpMjXaSCYb960hiQOxcpukAsOuggpMdrNAZVpV8AARM
	xs1MvXaL5n9tzJ82+uQNyCqpGjRpsn+KKf9PRc10Hk8yFiz7ZFg+f4JgcgBMFB8eJo5MzFGjSyf
	nk6F0nE04IxakjD/1cUofOZQdXQc1yUMRs2hSXugL2v/KCfDrNk3D22ZbpYIfdlydVTgOl+bxs/
	/qTQj14VLDf05+PSjJlimUJAvp7S1rC+io/q/5mPZtTJEc5ZZxenoERsYo9jfiR+GrE/Q1jZREG
	bbSBfOBm/sGFaAc1Qgc1Or3brJHpaMWrlIIJYrYdVDnYVe/Fvd3SQ7qm99yliufURVSvhlhlQjp
	slELggaH0el/DSp6mr8ZM+vWWUk2PbU7j6ctJenGAPL5yS4niEYg6pwB3iYNaI5Q==
X-Received: by 2002:a05:690e:4004:b0:67d:bedd:494e with SMTP id 956f58d0204a3-67df40be117mr12076969d50.0.1795702544974;
        Thu, 26 Nov 2026 06:15:44 -0800 (PST)
X-Received: by 2002:a05:690e:4004:b0:67d:bedd:494e with SMTP id 956f58d0204a3-67df40be117mr12076951d50.0.1795702544570;
        Thu, 26 Nov 2026 06:15:44 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm39706018f8f.30.2026.11.26.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:15:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vincent Mailhol <mailhol@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH V2 0/6] ARM: mxs: add EVAchargeSE board support
Date: Thu, 26 Nov 2026 15:15:41 +0100
Message-ID: <179570253918.23340.11898101233717977206.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112130506.12823-1-wahrenst@gmx.net>
References: <20261112130506.12823-1-wahrenst@gmx.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W1Bea-zS2zesWbNM1ASSuCjdgheX7xB2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX+UV0X5O4e/xJ
 oFcx+aUGn1r5TxORxg6szXLs/SZSs6/omC4fgaIrPVqjauQ9P7yLRcCM83mYALZ1PQf7HNcjfJa
 DiQfGzQRm+7GDzr4R2PxitOCd5KD4ZQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX/SDUBahHQbRN
 prsPLGYM+csCSz+b6Ps2/jrhjO/yzqajFW+FIT+SfBLyeuGdQbGRUN76JNalXbFspZZZ5WC/q2/
 SJyJNNHCbBYXnyt+YhaxfQGWZhchb2fgfvt4WyLXHgTqSbVIA7IDYvHJ+VGQ14pmUMEDobDkvdn
 SygZlV0KkMD5Q3d02DDB71sE3d7hlK/KPIeouTeyS1//qtwCH+wEQHaCzC53xuLc8G1WicNiLKa
 fBOjGDYBel51npi1lFnFlD/kYRRrinOHjOVyEgoe2yb5V8AHyuYifE2+QCUR9z/MaOYmF9qmSGc
 MtYIF2CGkTAnbWzMCmPZZDvxEACvDzHh1PPz5mWnmnQ4MUhGVPdSH4LAAb6W6dewC6czlZ9oefg
 IfNHGjZu3TjzK83GGsNKzwNiqs0QNVpnpBQcNVfwIF2SBquFbiE+fPLe8/m3nzWJDdAWM+wp5A2
 nLLeC4Npn3Ftv1SsU6w==
X-Proofpoint-ORIG-GUID: W1Bea-zS2zesWbNM1ASSuCjdgheX7xB2
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b083f11 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WIf87rlHEhZ3lBRYjGYA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260055


On Thu, 12 Nov 2026 14:04:59 +0100, Stefan Wahren wrote:
> This series adds support for the chargebyte EVAcharge SE, which is a
> ISO 15118 compliant controller for electric vehicle & charging stations.
> 
> Changes in V2:
> - add Krzysztof's Acked-by to Patches 1-3
> - align writing of EVAcharge SE (reported by sashiko)
> - add "dts:" to subject of Patch 5 (reported by Andrew)
> - add PHY ID of LAN8720Ai (reported by sashiko)
> - move enet_out clock to MAC node as in imx28-btt3.dtsi
> - adjust IRQ type of PHY (reported by Andrew)
> - add new patch to enable EVAcharge SE peripherals in mxs_defconfig
> 
> [...]

Applied, thanks!

[3/6] dt-bindings: gpio: mxs: Allow gpio-line-names to be set
      https://git.kernel.org/brgl/c/0a74985977e851196d69e5364f4787adb03a5fb5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
