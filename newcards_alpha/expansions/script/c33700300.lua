--Night March
--AlphaKretin
--For Nemoma
function c33700300.initial_effect(c)
	aux.AddEquipProcedure(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c33700300.atkval)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c33700300.atkcon)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--atk/def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetCondition(c33700300.atkcon2)
	e3:SetValue(2000)
	c:RegisterEffect(e3)
	--Pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCondition(c33700300.atkcon2)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
end
function c33700300.atkval(e,c)
	return (Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,TYPE_SPELL) * 100) + 100
end
function c33700300.atkcon(e)
	return Duel.GetMatchingGroupCount(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,33700300)==1
end
function c33700300.atkcon2(e)
	return Duel.GetMatchingGroupCount(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,33700300)==2
end
