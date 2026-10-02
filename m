Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276723D7F4;
	Fri,  2 Oct 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955094; cv=none; b=D+hF4wwEfyO7mhhKSpdXqsju65tTmuPmSMCg7Ng/YUFVm8llCzagA+Zvl6ggyiqZjXphfrxZqITMFKEJFn+pHDhJP8G6Qb1JwdEFib8t8vT56m07pMCTsedhhhjZsu4U4mQpniuKZi+wzZi8uU8FXYJARe7oj/V/2sYgSnSRT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955094; c=relaxed/simple;
	bh=95dkucxPGADp6gQm+VpfESFlbMOcIIRz3dt8riizcQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cH0DS2JnABrsCLUWjq7iPditThZRCw4WeD0fJVJgC8vj5MtyMdujf6UCYSFvuZ/XvyKshCGPV4av74v0fGRT+VDsjSrT5STLdxu+L5Jm0zVWEkudUWWQAtOZ4pzC8zBYT3ww8sA9Q+/F9tWMHjsWFFhCqTP8+BsS+KyBALn8DvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=aGLKlYxH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="aGLKlYxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790955085; x=1791559885; i=wahrenst@gmx.net;
	bh=95dkucxPGADp6gQm+VpfESFlbMOcIIRz3dt8riizcQo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aGLKlYxHgHtSwp6UtwuXsgoUeA1IouiGcv0cHKInIBZhIqazkAkgx2ud5wxxV81W
	 esExOuR85Qc4Oe+S1dN3sF0M2RdFcrO5lwjaJoPr32gF5CqbZqCk+feRbi0qm/Qm3
	 3PVZuAVe1gsABUeJNamF7TUn0ORZhAVqy8bNzR+c5YlnhfGGmAVfuzy9/eayZ1lx2
	 YMDQfRZNAVWyMqmV/H8moWp6j2WohPwbr31Q7SFn46hESw5YmWQGPxv9RsT86F286
	 P+gstTBOvjK4Sw0KQdzEzPkFywoPPgDCWIIMtKQRp5GneZ8sOv88OdRh+4I743U4r
	 DMTMYy9HmsMqLMxsjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1xRiAm2ITB-00HuFz; Fri, 02
 Oct 2026 17:31:25 +0200
Message-ID: <7cc6e394-9895-4f42-a0c1-f1fbd7eafbfa@gmx.net>
Date: Fri, 2 Oct 2026 17:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
From: Stefan Wahren <wahrenst@gmx.net>
To: Frank Li <Frank.li@oss.nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Fabio Estevam
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
 Aswath Govindraju <a-govindraju@ti.com>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net> <arFDUby0v52HSNnU@SMW015318>
 <1a7c722b-a4ff-45d5-a590-0910ac47b541@gmx.net>
Content-Language: en-US
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <1a7c722b-a4ff-45d5-a590-0910ac47b541@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ti88zxwXG0PNCj/HDiERVHlmeVKTyXeIBq8kQN1TEywM61/pzlR
 fZcirPvUk6yXefHLxiIecFIorAkEefvcwVuFwOkTJY/t9VAUa4jPdd143kC1ipfPt9eXzhX
 yzjbfhPoirE+CWbboy1n6cVXail+FhAV3/2PQf/fqRIbeQ+YsTCWhp5T81pZCStp2RN8iyC
 NTrcciXQe/kyO0n0sRMmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bJLaUhldQhY=;vp4yUG/JoWnM6b94lcSG8Ku6OFC
 L3vlEG9zy5hbYBjoTti9S50jaSyfqxVCv+jkcue+9zd2jJxj43Kt7Zfc80hjyNBa/L2TUdwJZ
 6efGBaFFtsF1fGFEsiGH6aa7I8xW8FR87QLI/TqiGtgRhiUIcvzrOnAQooNfSOn5MhEhVQ7uA
 9w2vB+OaA/LTbw4+GyYvuc5YuLrirNOHov6Z5NPt/oZcrFWWQ7l9lLrsSvklZm98GbPONrpQB
 kC1oLke/CriTBVeV0sydelFibMdd8/VFxOlPeDhL5zxwHBh9802/OFb4M3yhHvE8MI/9CDp4a
 YReHh/1tRF3XhqEqu6/0Z+cvNo/CMSj3sZoz3CIvx/asMGY9aJNKgw736g2hoBeleonmLRbjt
 BGOQXVrJzfAzZCRN8WV73aaVqc8EfMEdoJS9S10qO25MdNGRbny7eB6LgimXTsBppPh6lMlqq
 7l1rLaIvDzfD9Ol5D5SKXWiwQLx2/unUfeCN9X5QURYOQ00zqv7OQ8GxeYgxD8sFcs5zvl4CH
 aOb+jqUBumIfnbNwyMVPKi9O814os7n5H7gE20hFMRRVAwhFdAC9vKBKEg2qd6GmB4wCaydY2
 H9tZkYJ2AODdH/IEwhD9QUwmCbzZ457peTYNhE1hMyARiotiipsbaBJIaPY+63d0DjnIEalA8
 YHyzzxn2mXE0Qy0u86NU/gbREv89XuG8Pj3Ne4QxkrZBgsA7WI5aWZp+XGl/iq0ITAGeBmgdX
 uPJJ+7GXhkDzSKUpTtvEZGlkNWcbcwr/0ChRAg0L/2nQiAKjkpcJ+UvkBwltyaSQDzDmSyIgA
 1jZH2TBLhKYpDiQ46phDo9JtLnLFV/qtm+zGsUXVM1NY/b8pNhUhfc+lFEO7DtYeJr0E4GRcL
 YJw1a2wRwW3gQrqQtwJoAc6gt2DzSJ34AyzN+3hJNmeyFqyF7VDFxSu5hLTJCniJAoFbKztB5
 d1EeWzbSeuCcCXnc3aCS21VIQlRCQhH5RqonEcYHEPFu362CmFFyUMOCvuuqDk9MRqXl6IF7Y
 tyItkQR0ZMPVTvpDZeAjET9otDluNzwimMpv8RgieMedP6yan2jtEU4VmFeTnUOnskRwNDc3R
 TN+VcqHEFLglD3TGJhjuT+uohZwXHUgyoHed/DmGg9NajMgubkj/zz0oyeSYKJyVznyvUX3I5
 L8ck4UIwgQ92LlK8LlX44dqR/+pNtdfRRwL02OjxTDrhmlIYX4jbn0or14R440/ZLmXAut4mq
 /hzlf+zBTis8c/vF0ZMf6HZV+N3KLAe1nPVq/YNiu++CYEIFnxfROjK54hewWBBPTOxiONGTS
 R+gydLrZXlpJbnyoT1p5mzYZ6oE0Z6IPD0ldtxUP0HmMVQcYOo+dd4vuhFIFmaPw23J1mv4PG
 bm2IPcTalblmCTc0iMqKe3Ay63mx/INCoXmXCTvSB0F/zeomgWyvlfAsr0NIbYqohkrWI7/18
 LpFPjbvKxR9d0A24BiPUhM9EFk6QLVQX3eqis7IjjstLDKbfVR+8qzkAL25lKyv6xk6CjP9ln
 hzeJ7PL+MyUPZ68XrTkJVog1deY3hX5SYFuM9XE24t3cD8XoBkq/SeHSO3KWwwPQBsiDx8nAW
 EQQ8KkDUlwQtT6nvKwBG6Ag958+uGisGB09J7+XYy5KT51A/A/wdxbAQ+GTC2d8AzAVL+9Tf0
 dneQzdPkEgFUz3BEanvNUZ9ufdnsxBp5krJax6GoBeqNGOiE0O7WRlTz84ePULnjyiytcxLKt
 uKwGHlO9A9t1LHkt2KSqjtStcVllCHEMBohgreF+rN4dMrYQ5wVpBpstL8NsEFssD79XKPM3z
 uylSYNXpsnRFvcu9wdYx1EbUBqup9J0twOiAPAiidFB+41JnCGBbIbi14nN/xeWV/KALSpqZT
 PaDyV2Dez4vQt9iGj8KgBskaZ0Uplk79XyZlRoCz4vwUmZUZaLXGMhvnGhzYHVmy7tjSAeCuc
 NHNKrh3Fy6MpX8CAb/LbBmJFhqOHOSaqfRI2CGv8AukS8g7WyGhOZGMrMf/jxd2wnMlf9KeiG
 QaC0lKmUoOD4DqKwJxR+U4clE/ltJ2djCQ+ciOP3l/4de4THpKE3AY7xVwJIBwiYChjNhZQhf
 jkx4ONIGVdUQnPfXfwcPZDbNQMHXgo+U1V5YaWSx+phA/p5cvS4V3cVxXU4yqwlVOndafHowZ
 F1xhMg0uEXFMaPvXlubdbzyfcu0gEQrL2J0iaX/soyN8l6R0cPxI0o/wZBS4KOsyKk/F9NKb1
 XFjfn/kZqSpqyuUtuAaBwoWfDZpoMJ9h5ctBJtYf3l4puyiysmx4duAP8ZS6JiiInx9wbhy/R
 a6hqbePNRuzuXZy0TXZYwz4vmyIaC3936lypmQxf5G41ZrSjy1UCu+n7nXFi0rPEdplat2RGo
 77swS8YJejRyqvFNi3BiaMX+MYBouMQZNIKGk9EL4/n6O2zsS7fQvlVmUR40hfqV2YfyyKSBx
 r3qtUPHV7sNI7s+T7ZHGVD90ngDGErrknurXftNscreSgl/TgQtvHZbG9Sp5HyPysdiyV/Rb+
 qxwjOR4OltR2G5NPKny2d+YJV63T7F+xbRRkslXcg4NyJv1tvYyowfnx513Cr7hZDJfMTFL+g
 qiPbEEwvqw0QRTq8u4glSMzRNWbhdGVgfGX6egpmxrJmCbqYVNi5aqriXvyEp39hmzpZkp5Im
 VbTY/CMWEU84ecZYaZVePvmW6KavK3LDVMibJDi7pZ9vgrV/fljkXsSlify6MwGYtEdiSNTPG
 d0xaOOllCDUIxCzd+rpvs6UHZJYAiBmuiWMrSCWHEKfAeFeBF2HdI5YF2wmVP6LLfdU1laewv
 yztqIXcuD7JSWAZn/oRIOZvDBidXoureCz6BNmblwtF961o9mcuXn6n40XdtuQnuQ24gYBGed
 jRoFZQ7STAOxk0EU15qO/0yE1IKFV90OIfSxHAMnnTNyUAIt5TSoU3cpMSv7N/Gg37aZw4Kp+
 Tkcd+P6PC8LTzNs6AQqtkQEbu79DQwFZ3nk7/vnZrEZLi2DP1geeijP+LfghAUDKh4PrhVsA4
 HD1vRoBZS1LK8FPvFD3cBaZUGe8VYXa7c//5fTiKXzwgPizw68z//hgQVDhnS1ATMG6nvepfb
 sdGFV5hyAWKNiinBOx5mQO1K1TUpsX4x8SWXn9vQI07fjnsd6SGzysARQCETxkbewvm2/h4Uw
 8LZ3NDPomovL5DuQZJoOkXY4xxgMEDxG4M6kbfYtqaZQdv3k+4uHtY7aBefo0vU3JwnZwLcjM
 89ok4W0umxmIXAXBnEx0Wi0maLkrNwDU1zP9LSOsX+oDZhmIq0l3Rwlo3XSZzEj+OOyZK7Tpd
 0HDBh8I371q/HhUyIWojX+clP5q9O5kZtQRQCLasn4nFe8aujG/ZQ+pZSoG8HBCTiGpfBoDEc
 gLNnooK9lvWGa7RQuwWuY0PYp8kWh4yd0RvGpEzIOd1Dp8KcPEAFCMB+FdTcYDNMrXr9VB4oS
 Z1OeyeO3TXRdFdUa1PLBEi+LXjSTkKSKyGXKdOSxejWCzEwyTSFL1Gq9GlyBk8C6VLwnCqow4
 Ab1XNL0gmj2WRj6ShMbOKxDypz3LUhZvWkGDkfNqGvn/h+z9R9CUnfXKGv4a1usOosJ1UF9xG
 kykl4YWaQADAJvOF7bSz95cBPbcFNve/nfhqil7ZIS4UvORMuTMsT+Ctu2/rBOdF2LFkWVCHl
 6IqqkdwCgq0nuwP3buEtUKQOnDaBRpEgOp5Rqgv5kfSMOMhu2hvnVG3S096xkuuD2g3yywX9I
 pvsjp+zpxX5+oz7vQFLF3HQb9lgU509KfHUvE5Czpi/LZrEjlYa17MazxtZ23ge5aWHSjDX8P
 r4HZFHjgvPQJu70FGz3ZoR+Aw2ohU7m8ckoE935UAZvGQtNDqHoYss9g6L4Plq1WY1Whz8wZ8
 qtTiuNnCQQ07DG3QQWtCxXDfTQVU7L/7t0TaH6GW5ffMoByDJTqrwBeoXd8incdVHYoskOIGN
 N1LMVgo4sLSag97YpbYogiByOcR9VonFtOsOZIjvQGmoraW8xJT+MrMDEZFuBpEU3ChAOfN9+
 K55HL2AWlitWsJjliPpQGTC0vhq7lNeGr1R/TkOIhNpn1viDJPqsJMNGgx9MTnewns6t8iew0
 CXLKwHA9Vm5wLnIXkCvyRFa4lmX5DviN2r422yzP1A42+k6bpBLc+mvoTaQjaP+xA2GyNGCBG
 Q9HxGc32Xvmjm+uWeCLS0UZ//2U9fEZnTG091iA7tOI0n6mg5Myavcf27zAzEliZnH4BnP4XW
 vJZkZl76voh+ycx+MeXMuBDoTl89AN9e8gLDoyC9ABCptOle3bSy4QW0G8JIVokQKfK1tI1Bq
 3tkXgYqlstt9J5FkEaFfiRDD9RAxsCLpVTmRq+xGYtIFU9rMMDbixN9/F90kHdTfvj7wprTzD
 U+HQDcpbauu7+pWgcHA/fGqDf1x8qSd96qchzhLxcvo77Vw8eC2IrLiy5/i1JqnnXbKSODy3Y
 Yq2ytqWXP0aF1sDbQ6YJBLKqMFUoqXd3nU2scmpo0q8CpGE4gYYsBum2wxmf2e/5QeuHJStEJ
 z2snFelGTEQ51SiLNCR/fyMfclG4/CvA0sV2XYOEbnAbVwM3rOT2CqY6DBfkoo5EyUEK9UHWX
 zXqBWeQBXugzlP0Zzi8PdrTTVcxJUYRqC7vXDGtXfHop0mLxPX5+8ddZhUCvdtVDI19M1WP/4
 4s9kOICodUV6fa0IDqZ3gUOFNNg/TY4yDDO5ILp4MnrReExYhNMtml0rA4zS/GbbpJNpzdwW8
 4+3zNyfXFItTI/7iSagpcSmzQWOypRk/opkbbJkHN+aX6C1G4hqWb8UcZCCNm92b008JPPA2G
 9jRARc+TBlCuKkOVEh5vvG6/axCCx68h/COjJ1jZO5Psje32T3MDaoFDXKOE+koxIh1WwhZcJ
 mE1QwIgnLfeT4RTnVCNVKrjGDGSwp5KOp/mNpNE1BrfjCjry4kkXNbxOevAXLudbyuSINmR1J
 b9vbsJpryeRoS2Aon2RxOXgyad64pmk3q8hulwgzHIOoCElMhIoojn/ZN7gr8xlVhr57XvRzH
 Cs/8+LH8XIbhQQw0ONu6xwOJK6e402j6OpADyfLf5E3rPoLmRPu31b7J3KBlOiVRlpW+ioVzK
 jBfJ/718EVt1OxPPECHU8JqaRRiKLqMpQH1Z/PyrdH2ohwXhyrmkkcWYIiX5pRd/TbubwLzMd
 UaBI+tyehTZe8zAA6DRTXlWeQ521RSqZz1IoiZGknU1TxtW+Dg089i1HgVm4gY5dJnMj+yGdQ
 8hG286JT1RJeZ73da2Dhc8W+yotb3PEgtog28im3X29Y2Z7o3dqgIdnC6TXI/GornbE4aZUAw
 PUvqn4mMMR9x4jJGWNWXAZVw2jIPDgZkEZWRcruIMvP0NGxrdowE9EexXW0t/3ckYphvwolVU
 aLfp+tU7C5jklAcWjFlhRnrejwCfgEuEtN/ynuGWgXe3DNC9RM8XGaM/aj5K+1RRN8tPDRo2n
 TtBWpH/rvZNDz2IGeIQo2LIK7lLUKFGdlDAcwcxa/9+OzFx6eCvSlB8/FrPCrjNx7ZWIeu8Mb
 gLde6KRDmrCvE4d8WBk9ztUv4hFr8wg1CqtaxwC2hezNqleia+nKvPQ3D810xKnjeDns8INpA
 o3Sc89jcjLHEw3q2crnWmRWLIO34QcPV6p2+3B4qhYAJPrAMyoBv7xtXwt001bgP4RZuIh8aa
 72wmIZUUKoRkYFJk4VvvghDJvuYI68jOWgCX0+s6GEtqxebgAow3az65SPm2twSafxmuBlwXo
 mTkEcpR9qvX9x+umdPsun1kBkPziJvNkYFHKq3FXB/aHAolSawTbaalpHhnwUbIrBtOLYYQYM
 5RLQNIXjCXeMgMrSDIFK9hHTU3+REqweuXkt0UP4qKlfN3Gd59p9cOZWC9YiD+ThjMx79lDf6
 protZEge3elZJuyVCyFt/5t/+RNIy0DBmsdOcnhqpQ24rBUIiizk+bRMIMhDkECmaSH2ThKrs
 W6SAWKU2ANm1KnXgIrcq6um9Sfxi4U06lGyE/cqK4m3EwR1nEawGpPkRMO2GClxpBpODaiT3d
 M6S4Ou+SGSZcdIyWJx9LfD8pCzaISSCKTC+li+/zoHlBbKeU49CgxQrrS85u2XAxbNlsPoDhe
 9eLg7JQ8xC3mvhRIGyTTspqd4nHYT8LPGrEWb0Zt+JO55E7mDxh9J6Jfl7QXnKoQ22ROLyk4R
 5TG8dJ5XXfIVb1dcX3nbJ4CKnXsNDlkMBoJjmsc4tWoVKFCBcHbM717aKrCluObtw9kyCIFdU
 ASTvXY6ij2hcyXb8zBloYcH0WEZ5viMsQk/pfG44Ep8DCHE+N1/fO4h25pTErf15V+r05JBK5
 iRvLx/kxk4meQ1oPeh9tKDUFoa/vWoV891QhCY8jYTdXOXp4S3LeTWbLMT2j3AW7jB3x3R7Tf
 dqFsy5DhguBOJJPyfE/chilUag==

Hi Frank,

Am 23.09.26 um 11:19 schrieb Stefan Wahren:
> Hi Frank,
> hi Vinod,
>
> Am 21.09.26 um 16:46 schrieb Frank Li:
>> On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
>>> Hi Frank,
>>>
>>> Am 07.09.26 um 17:04 schrieb Stefan Wahren:
>>>> This series adds support for the chargebyte Charge Control Y, which i=
s
>>>> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
>>>> Charging System) charging stations.
>>>>
>>>> sashiko reported in the first version of the series [1] that=20
>>>> X_nRST_LAN
>>>> is available via GPIO line names, but there is no reset mechanismn=20
>>>> in the
>>>> device tree. This finding is valid. Since the reset line feature isn'=
t
>>>> implemented for LAN8651 driver yet, I like to proceed with the curren=
t
>>>> version. The LAN8651 handles reset via SPI commands and in rare cases
>>>> we still have the possibility to control the reset from userspace.
>>>> Btw the pin has a pull resistor in hardware, so it's not floating.
>>>>
>>>> sashiko complained in the fourth version of the series [2] about the
>>>> reset polarity of ethphy2 and the different drive strength across the
>>>> data lines. Both is intended.
>>>>
>>>> [1] -=20
>>>> https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9@=
smtp.kernel.org/
>>>> [2] -=20
>>>> https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000E9@=
smtp.kernel.org/
>>>>
>>>> Changes in V5:
>>>> - fix delete-node for pinctrl_leds (reported by sashiko)
>>>> - add Krzysztof's Reviewed-by
>>> I didn't received any feedback for V5 yet. Do you have any comments=20
>>> or could
>>> it be merged?
>> Wait for vinod pick phy binding part.
> @Vinod are you fine with both PHY bindings?
>
> @Frank I noticed that this patch has a conflict with the Makefile in=20
> linux-next. Should I rebase or do you resolve the conflict?
would it be better if I rebase now and send a V6, I concerned that this=20
misses the cycle.

Best regards
>
> Best regards
>>
>> Frank
>>
>>> Best regards
>>>
>

